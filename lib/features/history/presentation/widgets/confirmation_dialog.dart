import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news/core/theme/theme.dart';
import 'package:news/generated/l10n.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  final String title;
  final String content;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => _close(context),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () => _confirm(context),
            child: Text(
              S.of(context).clean,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    }

    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          onPressed: () => _confirm(context),
          isDestructiveAction: true,
          child: Text(
            S.of(context).clean,
            style: TextStyle(color: theme.cupertinoAlertColor),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () => _close(context),
          isDefaultAction: true,
          child: Text(
            S.of(context).cancel,
            style: TextStyle(color: theme.cupertinoActionColor),
          ),
        ),
      ],
    );
  }

  void _confirm(BuildContext context) {
    context.pop();
    onConfirm.call();
  }

  void _close(BuildContext context) => context.pop();
}
