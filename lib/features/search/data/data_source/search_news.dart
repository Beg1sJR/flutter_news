import 'package:dio/dio.dart';
import 'package:news/core/constants/data.dart';
import 'package:news/features/search/data/model/model.dart';

class SearchNewsData {
  final Dio dio;

  SearchNewsData({required this.dio});

  Future<SearchNewsModel> getNews(String query, int page, int pageSize) async {
    final response = await dio.get(
      '${DataConstants.baseURl}/v2/everything',
      queryParameters: {
        'q': query,
        'language': 'en',
        'sortBy': 'publishedAt',
        'pageSize': pageSize,
        'page': page,
        'apiKey': DataConstants.apiKey,
      },
    );

    final responseData = response.data;
    SearchNewsModel newsDetails = SearchNewsModel.fromMap(
      responseData as Map<String, dynamic>,
    );

    return newsDetails;
  }
}
