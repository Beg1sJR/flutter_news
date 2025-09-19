import 'package:dio/dio.dart';
import 'package:news/core/constants/data.dart';
import 'package:news/features/main/data/model/model.dart';

class TopNewsData {
  final Dio dio;

  TopNewsData({required this.dio});

  Future<NewsModel> getNews() async {
    final response = await dio.get(
      '${DataConstants.baseURl}/v2/top-headlines?country=us&apiKey=${DataConstants.apiKey}',
    );

    final responseData = response.data;
    NewsModel newsDetails = NewsModel.fromMap(
      responseData as Map<String, dynamic>,
    );

    return newsDetails;
  }
}
