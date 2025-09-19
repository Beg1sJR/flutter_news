import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:news/features/auth/presentation/logic/auth_bloc/auth_bloc.dart';
import 'package:news/features/profile/presentation/widgets/data/widgets.dart';
import 'package:news/generated/l10n.dart';

class DataChangePage extends StatefulWidget {
  const DataChangePage({super.key});

  @override
  State<DataChangePage> createState() => _DataChangePageState();
}

class _DataChangePageState extends State<DataChangePage> {
  final phoneMaskFormatter = MaskTextInputFormatter(
    mask: '### ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickAndSaveAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile == null) return;

    final cropped = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        AndroidUiSettings(cropStyle: CropStyle.circle),
        IOSUiSettings(cropStyle: CropStyle.circle),
      ],
    );
    if (cropped == null) return;

    if (!mounted) return;
    context.read<AuthBloc>().add(UpdateUserAvatar(File(cropped.path)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UpdateUserDataError) {
          _showSnackBar(
            context,
            'Ошибка при обновлении данных: ${state.error}',
            Colors.red,
          );
          log('Error updating user data: ${state.error}');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            final avatarUrl = state.appUser?.avatarUrl;
            log('avatarUrl: ${avatarUrl ?? 'no avatar url'}');

            return Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: theme.cardColor,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  S.of(context).myDetails,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          (avatarUrl != null &&
                                              avatarUrl.isNotEmpty)
                                          ? NetworkImage(avatarUrl)
                                          : const NetworkImage(
                                              'https://via.placeholder.com/150',
                                            ),
                                      child:
                                          (avatarUrl == null ||
                                              avatarUrl.isEmpty)
                                          ? Text(
                                              'УН',
                                              style: const TextStyle(
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                _pickAndSaveAvatar();
                              },
                              child: Text(
                                S.of(context).changePhoto,
                                style: const TextStyle(
                                  color: Color(0xFF3498DB),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Form Section
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).personalInfromation,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            CustomTextField(
                              controller: _nameController
                                ..text =
                                    state.appUser?.username ??
                                    state.user.displayName ??
                                    S.of(context).noName,
                              label: S.of(context).fullName,
                              icon: Icons.person_outline,
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _phoneController
                                ..text =
                                    state.appUser?.phoneNumber ??
                                    '### ### ## ##',
                              label: S.of(context).phoneNumber,
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [phoneMaskFormatter],
                              prefixText: '+7 ',
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SaveButton(
                        color: const Color(0xFF3498DB),
                        onPressed: state is UpdateUserDataLoading
                            ? null
                            : () {
                                final Map<String, dynamic> dataToUpdate = {
                                  'username': _nameController.text.trim(),
                                  'phoneNumber': _phoneController.text.trim(),
                                };
                                if (state.appUser?.username ==
                                    _nameController.text.trim()) {
                                  dataToUpdate.remove('username');
                                }
                                if (state.appUser?.phoneNumber ==
                                    _phoneController.text.trim()) {
                                  dataToUpdate.remove('phoneNumber');
                                }
                                if (state.appUser?.username ==
                                        _nameController.text.trim() &&
                                    state.appUser?.phoneNumber ==
                                        _phoneController.text.trim()) {
                                  _showSnackBar(
                                    context,
                                    S.of(context).noChangesToSave,
                                    Colors.grey,
                                  );
                                  return;
                                }

                                context.read<AuthBloc>().add(
                                  UpdateUserData(dataToUpdate),
                                );
                                _showSnackBar(
                                  context,
                                  S.of(context).detailsSuccessfullyUpdated,
                                  Colors.green,
                                );
                              },
                        child: state is UpdateUserDataLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                S.of(context).saveUpdates,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            );
          }
          // Display a loading indicator or an empty container for other states
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  void _showSnackBar(
    BuildContext context,
    String content,
    Color backgroundColor,
  ) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
