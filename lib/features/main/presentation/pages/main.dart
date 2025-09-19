import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/main/presentation/logic/news_bloc/news_bloc.dart';
import 'package:news/features/main/presentation/logic/top_news_bloc/top_news_bloc.dart';
import 'package:news/features/main/presentation/widgets/widgets.dart';
import 'package:news/generated/l10n.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<NewsBloc>().state;
    if (state is NewsLoaded && state.hasMore && !_isLoadingMore) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        setState(() {
          _isLoadingMore = true;
        });
        context.read<NewsBloc>().add(LoadMoreNews());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _resetLoadingFlag(NewsState state) {
    if (_isLoadingMore && state is NewsLoaded) {
      setState(() {
        _isLoadingMore = false;
      });
    }
    if (state is NewsError) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          S.of(context).newsFeed,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TopNewsBloc>().add(LoadTopNews());
          context.read<NewsBloc>().add(LoadNews());
        },
        child: ListView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                S.of(context).lastNews,
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            BlocBuilder<TopNewsBloc, TopNewsState>(
              builder: (context, state) {
                if (state is TopNewsLoading) {
                  return ShimmerTopNews();
                } else if (state is TopNewsLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 220,
                        child: PageView.builder(
                          itemCount: state.topNewsDetails.articles?.length ?? 0,
                          controller: PageController(viewportFraction: 0.92),
                          itemBuilder: (context, index) {
                            final article =
                                state.topNewsDetails.articles![index];
                            return TopNewsCard(
                              article: article,
                              onTap: () {
                                log('hello');
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                } else if (state is TopNewsError) {
                  return ErrorState(
                    error: state.error,
                    onRetry: () {
                      context.read<TopNewsBloc>().add(LoadTopNews());
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                S.of(context).recommendations,
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            BlocConsumer<NewsBloc, NewsState>(
              listener: (context, state) => _resetLoadingFlag(state),
              builder: (context, state) {
                if (state is NewsLoading) {
                  return ShimmerNewsList(itemCount: 5);
                } else if (state is NewsLoaded) {
                  final articles = state.newsDetails.articles ?? [];

                  return Column(
                    children: [
                      ...articles.map(
                        (article) => Column(
                          children: [
                            NewsContainer(article: article),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                          ],
                        ),
                      ),

                      if (state.hasMore)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: _isLoadingMore
                              ? const ShimmerNewsList(itemCount: 1)
                              : const SizedBox(height: 80),
                        ),
                    ],
                  );
                } else if (state is NewsError) {
                  return ErrorState(
                    error: state.error,
                    onRetry: () {
                      context.read<NewsBloc>().add(LoadNews());
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
