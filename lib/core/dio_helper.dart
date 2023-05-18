import 'package:dio/dio.dart';
import 'package:task/core/string/end_points.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://api.unsplash.com/',
          receiveDataWhenStatusError: true,
          headers: {'Authorization': accessKey}),
    );
  }

  static Future<Response> getData(
      {required String url, Map<String, dynamic>? query}) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
