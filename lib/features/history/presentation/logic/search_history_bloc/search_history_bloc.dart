import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/features/auth/presentation/logic/auth_bloc/auth_bloc.dart';
import 'package:news/features/history/domain/entity/search_history.dart';
import 'package:news/features/history/domain/repository/search_history.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final SearchHistoryRepository _searchHistoryRepository;
  final AuthBloc _authBloc;
  StreamSubscription? _historySubscription;
  late final StreamSubscription _authSubscription;

  SearchHistoryBloc(this._searchHistoryRepository, this._authBloc)
    : super(SearchHistoryInitial()) {
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<AddSearchQuery>(_onAddSearchQuery);
    on<DeleteSearchQuery>(_onDeleteSearchQuery);
    on<ClearSearchHistory>(_onClearSearchHistory);
    on<WatchSearchHistory>(_onWatchSearchHistory);

    _authSubscription = _authBloc.stream.listen((authState) {
      add(WatchSearchHistory());
    });
    add(WatchSearchHistory());
  }

  Future<void> _onLoadSearchHistory(
    LoadSearchHistory event,
    Emitter<SearchHistoryState> emit,
  ) async {
    emit(SearchHistoryLoading());
    try {
      final history = await _searchHistoryRepository.loadHistory();
      emit(SearchHistoryLoaded(history));
    } catch (e) {
      emit(SearchHistoryError(e.toString()));
    }
  }

  Future<void> _onAddSearchQuery(
    AddSearchQuery event,
    Emitter<SearchHistoryState> emit,
  ) async {
    try {
      await _searchHistoryRepository.addQuery(event.keyword);
      add(LoadSearchHistory());
    } catch (e) {
      emit(SearchHistoryError(e.toString()));
    }
  }

  Future<void> _onDeleteSearchQuery(
    DeleteSearchQuery event,
    Emitter<SearchHistoryState> emit,
  ) async {
    try {
      await _searchHistoryRepository.deleteQuery(event.id);
      add(LoadSearchHistory());
    } catch (e) {
      emit(SearchHistoryError(e.toString()));
    }
  }

  Future<void> _onClearSearchHistory(
    ClearSearchHistory event,
    Emitter<SearchHistoryState> emit,
  ) async {
    emit(SearchHistoryLoading());
    try {
      await _searchHistoryRepository.clearHistory();
      emit(const SearchHistoryLoaded([]));
    } catch (e) {
      emit(SearchHistoryError(e.toString()));
    }
  }

  Future<void> _onWatchSearchHistory(
    WatchSearchHistory event,
    Emitter<SearchHistoryState> emit,
  ) async {
    emit(SearchHistoryLoading());
    _historySubscription?.cancel();
    _historySubscription = _searchHistoryRepository.watchHistory().listen((
      history,
    ) {
      add(SearchHistoryUpdated(history));
    });
    await emit.forEach<List<SearchHistoryEntity>>(
      _searchHistoryRepository.watchHistory(),
      onData: (history) => SearchHistoryLoaded(history),
      onError: (error, _) => SearchHistoryError(error.toString()),
    );
  }

  @override
  Future<void> close() {
    _historySubscription?.cancel();
    _authSubscription.cancel();
    return super.close();
  }
}
