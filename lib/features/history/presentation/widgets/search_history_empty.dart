import 'package:flutter/material.dart';
import 'package:news/generated/l10n.dart';

class SearchHistoryEmpty extends StatelessWidget {
  const SearchHistoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: theme.hintColor.withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).searchHistoryIsEmpty,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).hereWillDisplayYourSearchWords,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
