import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/auth/presentation/logic/auth_bloc/auth_bloc.dart';
import 'package:news/features/auth/presentation/widgets/login/reset_password/widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();

  bool _hasInput = false;
  bool _isEmailSent = false;
  String _errorMessage = '';
  bool _isEmailError = false;

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  void _addListeners() {
    _emailController.addListener(_onDataChanged);
  }

  void _onDataChanged() {
    setState(() {
      _hasInput = _emailController.text.isNotEmpty;
      _errorMessage = '';
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _resendEmail() {
    setState(() {
      _isEmailSent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C3E50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Сброс пароля',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              // Email Icon Section
              EmailIconSection(isEmailSent: _isEmailSent),

              if (!_isEmailSent) ...[
                SizedBox(height: 20),

                // Email Form Section
                EmailFormField(
                  emailController: _emailController,
                  validator: (value) =>
                      value != null && !EmailValidator.validate(value)
                      ? 'Введите корректный email'
                      : null,
                  isEmailError: _isEmailError,
                  errorMessage: _errorMessage,
                ),

                SizedBox(height: 20),

                // Info Section
                InfoStep(),

                SizedBox(height: 30),

                // Send Reset Email Button
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is PasswordResetSuccess) {
                      setState(() {
                        _isEmailSent = true;
                      });
                    } else if (state is PasswordResetFailure) {
                      setState(() {
                        _isEmailError = !_isEmailError;
                        _errorMessage = state.error;
                      });
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: !_hasInput || state is PasswordResetLoading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                    ResetPassword(
                                      email: _emailController.text.trim(),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _hasInput
                                ? Color(0xFF3498DB)
                                : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: _hasInput ? 2 : 0,
                          ),
                          child: state is PasswordResetLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Отправить письмо',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: _hasInput
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ],

              if (_isEmailSent) ...[
                SizedBox(height: 30),

                // Success Actions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Resend Email Button
                      ResendEmailButton(onPressed: _resendEmail),

                      SizedBox(height: 16),

                      // Back to Login Button
                      BackToLoginButton(),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
