import 'package:apple_shop/utils/auth_manager.dart';
import 'package:dio/dio.dart';

class DioProvider {
 static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(baseUrl: 'http://startflutter.ir/api/',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AuthManager.readAuth()}'
      }),
    );

    return dio;
  }

 static Dio createDioWithoutHeaders() {
    Dio dio = Dio(
      BaseOptions(baseUrl: 'http://startflutter.ir/api/'),
    );

    return dio;
  }
}
