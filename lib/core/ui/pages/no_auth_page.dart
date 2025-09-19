import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news/generated/l10n.dart';

class NoAuthPage extends StatelessWidget {
  const NoAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/login');
          },
          style: ElevatedButton.styleFrom(
            surfaceTintColor: theme.primaryColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            S.of(context).login,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
