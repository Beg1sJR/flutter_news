import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/features/search/data/model/model.dart';
import 'package:news/features/search/domain/repository/search_news.dart';

part 'search_news_event.dart';
part 'search_news_state.dart';

class SearchNewsBloc extends Bloc<SearchNewsEvent, SearchNewsState> {
  final SearchNewsRepository searchNewsRepository;
  static const int _pageSize = 10;
  SearchNewsBloc(this.searchNewsRepository) : super(SearchNewsInitial()) {
    on<LoadSearchNews>(_loadSearchNews);

    on<LoadMoreSearchNews>(_loadMoreSearchNews);
  }

  Future<void> _loadMoreSearchNews(event, emit) async {
    if (state is SearchNewsLoaded) {
      final currentState = state as SearchNewsLoaded;
      final nextPage = currentState.currentPage + 1;
      try {
        final searchNewsDetails = await searchNewsRepository.getNews(
          event.query,
          nextPage,
          _pageSize,
        );
        final newArticles = searchNewsDetails.articles ?? [];

        final allArticles = <ArticlesModel>[
          ...?currentState.searchNewsDetails.articles,
          ...newArticles,
        ];

        final mergedSearchNewsDetails = currentState.searchNewsDetails.copyWith(
          articles: allArticles,
        );
        emit(
          SearchNewsLoaded(
            hasMore: newArticles.length == _pageSize,
            currentPage: nextPage,
            searchNewsDetails: mergedSearchNewsDetails,
          ),
        );
      } catch (e) {
        emit(SearchNewsError(error: e.toString()));
      }
    }
  }

  FutureOr<void> _loadSearchNews(event, emit) async {
    emit(SearchNewsLoading());
    try {
      final searchNewsDetails = await searchNewsRepository.getNews(
        event.query,
        1,
        _pageSize,
      );
      final articles = searchNewsDetails.articles ?? [];
      emit(
        SearchNewsLoaded(
          searchNewsDetails: searchNewsDetails,
          hasMore: articles.length == _pageSize,
          currentPage: 1,
        ),
      );
    } catch (e) {
      emit(SearchNewsError(error: e.toString()));
    }
  }
}
