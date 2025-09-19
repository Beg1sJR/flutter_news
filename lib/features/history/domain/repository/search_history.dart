import 'package:news/features/history/domain/entity/search_history.dart';

abstract interface class SearchHistoryRepository {
  Future<void> addQuery(String keyword);
  Future<void> deleteQuery(String id);
  Stream<List<SearchHistoryEntity>> watchHistory();
  Future<List<SearchHistoryEntity>> loadHistory();
  Future<void> clearHistory();
}
