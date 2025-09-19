import 'package:dio/dio.dart';
import 'package:news/core/constants/data.dart';
import 'package:news/features/main/data/model/model.dart';

class NewsData {
  final Dio dio;

  NewsData({required this.dio});

  Future<NewsModel> getNews(int page, int pageSize) async {
    final response = await dio.get(
      '${DataConstants.baseURl}/v2/everything',
      queryParameters: {
        'q': 'mercedes',
        'language': 'en',
        'sortBy': 'publishedAt',
        'pageSize': pageSize,
        'page': page,
        'apiKey': DataConstants.apiKey,
      },
    );

    final responseData = response.data;
    NewsModel newsDetails = NewsModel.fromMap(
      responseData as Map<String, dynamic>,
    );

    return newsDetails;
  }
}
