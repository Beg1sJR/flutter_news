part of 'search_news_bloc.dart';

sealed class SearchNewsEvent extends Equatable {
  const SearchNewsEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchNews extends SearchNewsEvent {
  final String query;

  const LoadSearchNews({required this.query});

  @override
  List<Object> get props => [query];
}

class LoadMoreSearchNews extends SearchNewsEvent {
  final String query;

  const LoadMoreSearchNews({required this.query});

  @override
  List<Object> get props => [query];
}
