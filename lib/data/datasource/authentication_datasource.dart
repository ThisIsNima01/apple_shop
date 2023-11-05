import 'package:apple_shop/utils/api_exception.dart';
import 'package:apple_shop/utils/auth_manager.dart';
import 'package:apple_shop/utils/dio_provider.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationDataSource {
  Future<void> register(
      String username, String password, String passwordConfirm);
  Future<String> login(String username, String password);
}

class AuthenticationRemote implements IAuthenticationDataSource {
  final Dio _dio = DioProvider.createDioWithoutHeaders();

  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'username': username,
        'password': password,
        'passwordConfirm': passwordConfirm,
        'name': username,
      });

      if (response.statusCode == 200) {
        login(username, password);
      }
    } on DioException catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode,
          response: e.response);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post('collections/users/auth-with-password',
          data: {'identity': username, 'password': password});

      if (response.statusCode == 200) {
        AuthManager.saveUserId(response.data?['record']['id']);
        AuthManager.saveToken(response.data?['token']);
        AuthManager.saveUsername(response.data?['record']['name']);
        return response.data?['token'];
      }
    } on DioException catch (e) {
      throw ApiException(e.response?.data['message'], e.response?.statusCode);
    } catch (e) {
      throw ApiException('unknown error', 0);
    }
    return '';
  }
}
