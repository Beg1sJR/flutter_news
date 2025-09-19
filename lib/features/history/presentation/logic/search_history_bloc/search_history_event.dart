part of 'search_history_bloc.dart';

sealed class SearchHistoryEvent extends Equatable {
  const SearchHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadSearchHistory extends SearchHistoryEvent {
  @override
  List<Object> get props => [];
}

class AddSearchQuery extends SearchHistoryEvent {
  final String keyword;
  const AddSearchQuery(this.keyword);
  @override
  List<Object?> get props => [keyword];
}

class DeleteSearchQuery extends SearchHistoryEvent {
  final String id;
  const DeleteSearchQuery(this.id);
  @override
  List<Object?> get props => [id];
}

class ClearSearchHistory extends SearchHistoryEvent {
  const ClearSearchHistory();
}

class WatchSearchHistory extends SearchHistoryEvent {}

class SearchHistoryUpdated extends SearchHistoryEvent {
  final List<SearchHistoryEntity> searchHistory;
  const SearchHistoryUpdated(this.searchHistory);
  @override
  List<Object?> get props => [searchHistory];
}
