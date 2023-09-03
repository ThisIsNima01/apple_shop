class ApiException implements Exception {
  String? message;
  int? code;

  ApiException(this.message, this.code);
}