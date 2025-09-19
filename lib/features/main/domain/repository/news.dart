import 'package:news/features/main/data/model/model.dart';

abstract interface class NewsRepository {
  Future<NewsModel> getNews(int page, int pageSize);
}
