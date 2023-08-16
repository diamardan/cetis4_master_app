import 'dart:convert';

import 'package:datamex_master_app/app/data/http/http.dart';
import 'package:datamex_master_app/app/domain/either.dart';
import 'package:datamex_master_app/app/domain/enums.dart';

class AuthenticationService {
  AuthenticationService(this._http);
  final Http _http;
  //final _baseUrl = AppConstants.baseUrl;

  Future<Either<SignInFailure, String>> createRequestToken(
      String email, String password) async {
    final result = await _http.request('/auth/login',
        method: HttpMethod.post, body: {'email': email, 'password': password});

    return result.when(
      (failure) {
        if (failure.exception is NetworkException) {
          return Either.left(SignInFailure.network);
        }
        return Either.left(SignInFailure.unknown);
      },
      (responseBody) {
        final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        return Either.right(json['token'] as String);
      },
    );
  }

  createSessionWithLogin(
      {required String email,
      required String password,
      required String token}) {
    return null;
  }
}
