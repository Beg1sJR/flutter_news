import 'package:news/features/main/data/model/model.dart';

abstract interface class TopNewsRepository {
  Future<NewsModel> getTopNews();
}
