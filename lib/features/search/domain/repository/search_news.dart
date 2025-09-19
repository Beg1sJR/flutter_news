import 'package:news/features/search/data/model/model.dart';

abstract interface class SearchNewsRepository {
  Future<SearchNewsModel> getNews(String query, int page, int pageSize);
}
