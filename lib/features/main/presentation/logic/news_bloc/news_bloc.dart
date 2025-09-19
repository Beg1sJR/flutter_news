import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/features/main/data/model/model.dart';
import 'package:news/features/main/domain/repository/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  static const int _pageSize = 10;
  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<LoadNews>(_loadNews);

    on<LoadMoreNews>(_loadMoreNews);
  }

  FutureOr<void> _loadMoreNews(event, emit) async {
    if (state is NewsLoaded) {
      final currentState = state as NewsLoaded;
      final nextPage = currentState.currentPage + 1;
      try {
        final newsModel = await newsRepository.getNews(nextPage, _pageSize);
        final newArticles = newsModel.articles ?? [];

        final allArticles = <ArticlesModel>[
          ...?currentState.newsDetails.articles,
          ...newArticles,
        ];

        final mergedNewsDetails = currentState.newsDetails.copyWith(
          articles: allArticles,
        );
        emit(
          NewsLoaded(
            newsDetails: mergedNewsDetails,
            hasMore: newArticles.length == _pageSize,
            currentPage: nextPage,
          ),
        );
      } catch (e) {
        emit(NewsError(error: e.toString()));
      }
    }
  }

  FutureOr<void> _loadNews(event, emit) async {
    emit(NewsLoading());
    try {
      final newsDetails = await newsRepository.getNews(1, _pageSize);
      final articles = newsDetails.articles ?? [];

      emit(
        NewsLoaded(
          newsDetails: newsDetails,
          hasMore: articles.length == _pageSize,
          currentPage: 1,
        ),
      );
    } catch (e) {
      emit(NewsError(error: e.toString()));
    }
  }
}
