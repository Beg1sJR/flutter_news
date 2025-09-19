import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class DataConstants {
  static final String baseURl = dotenv.env['BASE_URL'] ?? '';
  static final String apiKey = dotenv.env['API_KEY'] ?? '';
}
