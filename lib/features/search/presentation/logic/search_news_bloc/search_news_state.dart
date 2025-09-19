part of 'search_news_bloc.dart';

sealed class SearchNewsState extends Equatable {
  const SearchNewsState();

  @override
  List<Object> get props => [];
}

final class SearchNewsInitial extends SearchNewsState {
  @override
  List<Object> get props => [];
}

final class SearchNewsLoading extends SearchNewsState {
  @override
  List<Object> get props => [];
}

final class SearchNewsLoaded extends SearchNewsState {
  final SearchNewsModel searchNewsDetails;
  final bool hasMore;
  final int currentPage;

  const SearchNewsLoaded({
    required this.hasMore,
    required this.currentPage,
    required this.searchNewsDetails,
  });

  @override
  List<Object> get props => [searchNewsDetails, hasMore, currentPage];
}

final class SearchNewsError extends SearchNewsState {
  final String error;
  const SearchNewsError({required this.error});
  @override
  List<Object> get props => [error];
}
