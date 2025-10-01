import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/bloc/cubit/settings_cubit.dart';
import 'package:news/features/auth/presentation/logic/auth_bloc/auth_bloc.dart';
import 'package:news/features/auth/presentation/widgets/login/login.dart'
    hide PasswordTextField;
import 'package:news/features/auth/presentation/widgets/register/register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isError = false;
  bool isPasswordsMatch = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = context.watch<SettingsCubit>().state.brightness;
    bool isDark = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Заголовок
                const Text(
                  'Создать аккаунт',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 8),
                Text(
                  'Заполните форму для регистрации',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),

                // Имя
                NameTextField(nameController: _nameController),
                const SizedBox(height: 16),
                PhoneTextField(phoneController: _phoneController),
                const SizedBox(height: 16),

                // Email
                EmailTextFiled(emailController: _emailController),
                const SizedBox(height: 16),

                // Пароль
                PasswordTextField(
                  passwordController: _passwordController,
                  obscurePassword: _obscurePassword,
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Подтверждение пароля
                PasswordTextField(
                  passwordController: _confirmPasswordController,
                  obscurePassword: _obscureConfirmPassword,
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Кнопка регистрации
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      context.go('/main');
                    } else if (state is RegisterFirebaseFailure) {
                      setState(() {
                        isError = true;
                        isPasswordsMatch = true;
                      });
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (isError)
                          ErrorContainer(
                            errorMessage:
                                'Проверьте правильность введенных данных',
                          ),

                        if (isPasswordsMatch == false)
                          ErrorContainer(
                            errorMessage: 'Пароли должны совпадать',
                          ),

                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: state is RegisterFirebaseLoading
                                ? null
                                : () {
                                    setState(() {
                                      isError = false;
                                      if (_passwordController.text ==
                                          _confirmPasswordController.text) {
                                        isPasswordsMatch = true;
                                        context.read<AuthBloc>().add(
                                          RegisterFirebase(
                                            email: _emailController.text.trim(),
                                            password: _passwordController.text
                                                .trim(),
                                            username: _nameController.text
                                                .trim(),
                                            phoneNumber: _phoneController.text
                                                .trim(),
                                          ),
                                        );
                                      } else {
                                        isPasswordsMatch = false;
                                      }
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? Color(0xFF2C3E50)
                                  : Color(0xFF3498DB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: state is RegisterFirebaseLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Зарегистрироваться',
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

                // Переход к входу
                GoLogin(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
