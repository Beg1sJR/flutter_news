import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/theme/theme.dart';
import 'package:news/features/history/presentation/logic/search_history_bloc/search_history_bloc.dart';
import 'package:news/features/history/presentation/widgets/widgets.dart';
import 'package:news/generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          S.of(context).historyOfSearch,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            onPressed: () {
              _showDialog(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
        builder: (context, state) {
          if (state is SearchHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchHistoryLoaded) {
            final searchHistory = state.searchHistory;
            log(searchHistory.toList().toString());
            if (searchHistory.isEmpty) {
              return SearchHistoryEmpty();
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: searchHistory.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, indent: 68, endIndent: 16),
              itemBuilder: (context, index) {
                final item = searchHistory[index];
                final query = item.keyword;
                final timestamp = item.timestamp;
                final totalResults = item.totalResults ?? 0;
                timeago.setLocaleMessages('ru', timeago.RuMessages());
                String formatted = timeago.format(timestamp, locale: 'ru');
                return SearchHistoryListTile(
                  totalResults: totalResults,
                  query: query,
                  formatted: formatted,
                  icon: Icons.history,
                  onPressed: () {
                    context.read<SearchHistoryBloc>().add(
                      DeleteSearchQuery(item.id),
                    );
                  },
                );
              },
            );
          } else if (state is SearchHistoryError) {
            return Center(
              child: Text(
                'Ошибка: ${state.message}',
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final theme = Theme.of(context);
    final dialog = ConfirmationDialog(
      title: S.of(context).clearHistory,
      content: S.of(context).youSureYouWantClearHistory,
      onConfirm: () => _cleanHisotry(context),
    );
    if (theme.isAndroid) {
      showDialog(context: context, builder: (context) => dialog);
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: true,
    );
  }

  void _cleanHisotry(BuildContext context) =>
      context.read<SearchHistoryBloc>().add(const ClearSearchHistory());
}
