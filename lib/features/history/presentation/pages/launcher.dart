// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/ui/pages/no_auth_page.dart';
import 'package:news/features/auth/presentation/logic/auth_bloc/auth_bloc.dart';
import 'package:news/features/history/presentation/pages/history.dart';

class HistoryLauncherPage extends StatelessWidget {
  const HistoryLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial ||
              state is LoginFirebaseLoading ||
              state is RegisterFirebaseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthAuthenticated) {
            return const HistoryPage();
          } else if (state is AuthUnauthenticated) {
            return const NoAuthPage();
          } else if (state is LoginFirebaseFailure) {
            return Center(child: Text('Ошибка входа: ${state.error}'));
          } else if (state is RegisterFirebaseFailure) {
            return Center(child: Text('Ошибка регистрации: ${state.error}'));
          } else {
            return const Center(child: Text('Что-то не так'));
          }
        },
      ),
    );
  }
}
