part of 'search_history_bloc.dart';

sealed class SearchHistoryState extends Equatable {
  const SearchHistoryState();

  @override
  List<Object> get props => [];
}

class SearchHistoryInitial extends SearchHistoryState {
  @override
  List<Object> get props => [];
}

class SearchHistoryLoading extends SearchHistoryState {
  @override
  List<Object> get props => [];
}

class SearchHistoryLoaded extends SearchHistoryState {
  final List<SearchHistoryEntity> searchHistory;
  const SearchHistoryLoaded(this.searchHistory);
  @override
  List<Object> get props => [searchHistory];
}

class SearchHistoryError extends SearchHistoryState {
  final String message;
  const SearchHistoryError(this.message);
  @override
  List<Object> get props => [message];
}
