import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news/features/auth/presentation/logic/auth_bloc/auth_bloc.dart';
import 'package:news/features/auth/presentation/widgets/login/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool isError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(),
              // Заголовок
              const Text(
                'Добро пожаловать',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 8),
              Text('Войдите в свой аккаунт', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 48),

              // Email поле
              EmailTextField(controller: _emailController),
              const SizedBox(height: 16),

              // Password поле
              PasswordTextField(
                controller: _passwordController,
                obscurePassword: _obscurePassword,
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 12),
              // Забыли пароль
              ForgotPassword(),
              const SizedBox(height: 24),

              // Кнопка входа
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    context.go('/main');
                  } else if (state is LoginFirebaseFailure) {
                    setState(() {
                      isError = true;
                    });
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      if (isError)
                        ErrorContainer(
                          errorMessage: 'Неверная почта или не зарегистрирован',
                        ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: state is LoginFirebaseLoading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                    LoginFirebase(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                                  FocusScope.of(context).unfocus();

                                  setState(() {
                                    isError = false;
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2C3E50),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: state is LoginFirebaseLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Войти',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              CustomDivider(),

              const SizedBox(height: 24),

              // Переход к регистрации
              GoRegister(),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
