import 'package:news/features/search/data/data_source/search_news.dart';
import 'package:news/features/search/data/model/news.dart';
import 'package:news/features/search/domain/repository/search_news.dart';

class SearchNewsRepositoryImpl implements SearchNewsRepository {
  final SearchNewsData searchNewsData;

  SearchNewsRepositoryImpl({required this.searchNewsData});
  @override
  Future<SearchNewsModel> getNews(String query, int page, int pageSize) async {
    final searchNewsDetails = await searchNewsData.getNews(
      query,
      page,
      pageSize,
    );

    return searchNewsDetails;
  }
}
