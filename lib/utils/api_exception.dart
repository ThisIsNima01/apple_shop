class ApiException implements Exception {
  String? message;
  int? code;

  ApiException(this.message, this.code) {
    if (code != 400) {
      return;
    }

    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمزعبور اشتباه است';
    }
  }
}
