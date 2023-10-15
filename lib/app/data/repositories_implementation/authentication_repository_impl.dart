import 'package:cetis4_master_app/app/data/services/remote/authentication.service.dart';
import 'package:cetis4_master_app/app/domain/either.dart';
import 'package:cetis4_master_app/app/domain/enums.dart';
import 'package:cetis4_master_app/app/domain/models/user.dart';
import 'package:cetis4_master_app/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(
      this._secureStorage, this._authenticationService);
  final FlutterSecureStorage _secureStorage;
  final AuthenticationService _authenticationService;

  @override
  Future<User?> getUserData() {
    // TODO: implement getUserData
    return Future.value(User());
  }

  @override
  // TODO: implement isSignedIn
  Future<bool> get isSignedIn async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  ) async {
    final tokenResult =
        await _authenticationService.createRequestToken(username, password);

    return tokenResult.when(
      (failure) => Either.left(failure),
      (token) async {
        await Future.delayed(const Duration(seconds: 2));

        await _secureStorage.write(key: _key, value: '123');
        await _secureStorage.write(key: 'token', value: token);
        return Either.right(User());
      },
    );

    /*  if (token == null) {
      return Either.left(SignInFailure.unauthorized);
    } */
    /* if (username != 'test') {
      return Either.left(SignInFailure.notFound);
    }
    if (password != '123456') {
      return Either.left(SignInFailure.unauthorizad);
    } */
  }

  @override
  Future<void> signOut() {
    return _secureStorage.delete(key: _key);
  }
}
