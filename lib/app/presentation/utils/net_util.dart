class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, 'No tiene permisos: ');
}

class AppException implements Exception {
  AppException([this._message, this._prefix]);
  final _message;
  final _prefix;

  @override
  String toString() {
    return _message;
  }
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, 'Petición invalida: ');
}
