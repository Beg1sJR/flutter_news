import 'package:flutter/material.dart';
import 'package:news/generated/l10n.dart';

class SearchNewsEmpty extends StatelessWidget {
  const SearchNewsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 150),
          Icon(Icons.search, size: 80, color: theme.hintColor.withOpacity(0.3)),
          const SizedBox(height: 20),
          Text(
            S.of(context).enterWordToSearchNews,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
