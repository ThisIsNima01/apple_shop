import 'package:dio/dio.dart';

class ApiException implements Exception {
  String? message;
  int? code;
  Response<dynamic>? response;

  ApiException(this.message, this.code, {this.response}) {
    if (code != 400) {
      return;
    }

    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمزعبور اشتباه است';
    }

    if (message == 'Failed to create record.') {
      if (response?.data['data']['username'] != null) {
        if (response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
          message = 'نام کاربری نامعتبر است یا قبلا گرفته شده';
        }
      }
    }
  }
}
