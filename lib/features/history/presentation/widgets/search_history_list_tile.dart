import 'package:flutter/material.dart';

class SearchHistoryListTile extends StatelessWidget {
  const SearchHistoryListTile({
    super.key,
    required this.totalResults,
    required this.query,
    required this.formatted,
    required this.icon,
    this.onPressed,
  });

  final int totalResults;
  final String query;
  final String formatted;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: theme.colorScheme.primary),
      ),
      title: Text(query, style: theme.textTheme.titleMedium),
      subtitle: Text(
        formatted,
        style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.close, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
