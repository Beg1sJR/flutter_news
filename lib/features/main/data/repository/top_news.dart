import 'package:news/features/main/data/data_source/top_news.dart';
import 'package:news/features/main/data/model/news.dart';
import 'package:news/features/main/domain/repository/top_news.dart';

class TopNewsRepositoryImpl implements TopNewsRepository {
  final TopNewsData topNewsData;

  TopNewsRepositoryImpl({required this.topNewsData});

  @override
  Future<NewsModel> getTopNews() async {
    final NewsModel topNewsDetail = await topNewsData.getNews();
    return topNewsDetail;
  }
}
