import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/history/presentation/logic/search_history_bloc/search_history_bloc.dart';
import 'package:news/features/search/presentation/logic/search_news_bloc/search_news_bloc.dart';
import 'package:news/features/search/presentation/widgets/widgets.dart';
import 'package:news/generated/l10n.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<SearchNewsBloc>().state;
    if (state is SearchNewsLoaded && state.hasMore && !_isLoadingMore) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        setState(() {
          _isLoadingMore = true;
        });
        context.read<SearchNewsBloc>().add(
          LoadMoreSearchNews(query: _searchController.text.trim()),
        );
      }
    }
  }

  void _resetLoadingFlag(SearchNewsState state) {
    if (_isLoadingMore && state is SearchNewsLoaded) {
      setState(() {
        _isLoadingMore = false;
      });
    }
    if (state is SearchNewsError) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Hero(
            tag: 'search_field',
            child: Material(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        fillColor: theme.colorScheme.surfaceContainerHighest
                            .withOpacity(0.5),
                        filled: true,
                        hintText: S.of(context).searchNews,
                        hintStyle: TextStyle(
                          color: theme.hintColor,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  IconButton(
                    onPressed: () {
                      if (_searchController.text.trim().isEmpty) return;
                      context.read<SearchNewsBloc>().add(
                        LoadSearchNews(query: _searchController.text.trim()),
                      );
                    },
                    icon: Icon(Icons.search_outlined),
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      foregroundColor: theme.colorScheme.primary,
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: theme.scaffoldBackgroundColor,
      ),
      body: ListView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,

        children: [
          BlocConsumer<SearchNewsBloc, SearchNewsState>(
            listener: (context, state) async {
              if (state is SearchNewsLoaded) {
                final keyword = _searchController.text.trim();

                if (state.currentPage == 1 && keyword.isNotEmpty) {
                  context.read<SearchHistoryBloc>().add(
                    AddSearchQuery(keyword),
                  );
                }
              }
              _resetLoadingFlag(state);
            },
            builder: (context, state) {
              if (state is SearchNewsInitial) {
                return SearchNewsEmpty();
              } else if (state is SearchNewsLoading) {
                return ShimmerSearchNewsCard(itemCount: 5);
              } else if (state is SearchNewsLoaded) {
                final articles = state.searchNewsDetails.articles ?? [];

                if (articles.isEmpty) {
                  return Center(
                    child: Text('No result', style: theme.textTheme.bodyLarge),
                  );
                }

                return Column(
                  children: [
                    ...articles.map(
                      (article) => Column(
                        children: [
                          SearchResultCard(article: article),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                        ],
                      ),
                    ),

                    if (state.hasMore)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _isLoadingMore
                            ? const ShimmerSearchNewsCard(itemCount: 1)
                            : const SizedBox(height: 80),
                      ),
                  ],
                );
              } else if (state is SearchNewsError) {
                return Center(
                  child: Text(
                    'Error: ${state.error}',
                    style: theme.textTheme.bodyLarge,
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
