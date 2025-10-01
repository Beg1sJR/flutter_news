import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/theme/theme.dart';
import 'package:news/features/auth/presentation/logic/auth_bloc/auth_bloc.dart';
import 'package:news/features/profile/presentation/widgets/profile/widgets.dart';
import 'package:news/generated/l10n.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final avatarUrl = state.appUser?.avatarUrl;

          final appUser = state.appUser;
          log('appUser: $appUser');
          final userName =
              appUser?.username ?? state.user.displayName ?? 'User Name';
          log('userName: $userName');
          final phoneNumber = appUser?.phoneNumber ?? '### ### ## ##';
          log('phoneNumber: $phoneNumber');
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: theme.cardColor,
              elevation: 0,
              centerTitle: true,
              title: Text(
                S.of(context).profile,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Profile header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
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
                                  // child:
                                  //     (avatarUrl == null || avatarUrl.isEmpty)
                                  //     ? Text(
                                  //         'УН',
                                  //         style: const TextStyle(
                                  //           fontSize: 36,
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       )
                                  //     : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          userName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+7 $phoneNumber',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Menu items
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ProfileTile(
                          icon: Icons.person_outline_rounded,
                          title: S.of(context).myDetails,
                          color: Colors.blue,
                          onTap: () {
                            context.push('/profile/data');
                          },
                        ),
                        Divider(height: 1, indent: 16, endIndent: 16),
                        ProfileTile(
                          icon: Icons.email_outlined,
                          title: S.of(context).textToSupport,
                          color: Colors.green,
                          onTap: () => _openSupport(context),
                        ),
                        Divider(height: 1, indent: 16, endIndent: 16),
                        ProfileTile(
                          icon: Icons.settings_outlined,
                          title: S.of(context).settings,
                          color: Colors.orange,
                          onTap: () {
                            context.push('/profile/settings');
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: () {
                          context.read<AuthBloc>().add(Logout());

                          context.go('/main');
                        },
                        icon: Icon(Icons.logout_rounded),
                        label: Text(S.of(context).logOut),
                        style: TextButton.styleFrom(
                          backgroundColor: theme.cardColor,

                          foregroundColor: Colors.red,

                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  void _openSupport(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      showModalBottomSheet(
        context: context,
        builder: (context) => const SupportBottomSheet(),
      );
      return;
    }
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const SupportBottomSheet(),
    );
  }
}
