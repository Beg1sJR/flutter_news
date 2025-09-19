import 'package:news/features/main/data/data_source/news.dart';
import 'package:news/features/main/data/model/news.dart';
import 'package:news/features/main/domain/repository/news.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsData newsData;

  NewsRepositoryImpl({required this.newsData});

  @override
  Future<NewsModel> getNews(int page, int pageSize) async {
    final NewsModel newsDetails = await newsData.getNews(page, pageSize);

    return newsDetails;
  }
}
