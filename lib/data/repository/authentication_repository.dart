import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/api_exception.dart';
import 'package:apple_shop/utils/auth_manager.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);
  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository extends IAuthRepository {
  final IAuthenticationDataSource _datasource = locator.get();

  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register('nima2321', '12345678', '12345678');
      return right('ثبت نام با موفقیت انجام شد');
    } on ApiException catch (e) {
      return left(e.message ?? 'خطای نامشخص');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String accessToken = await _datasource.login(username, password);

      if (accessToken.isNotEmpty) {
        AuthManager.saveToken(accessToken);
        return right('شما وارد شدید');
      } else {
        return left('خطایی در ورود پیش آمده');
      }
    } on ApiException catch (e) {
      return left('${e.message}');
    }
  }
}
