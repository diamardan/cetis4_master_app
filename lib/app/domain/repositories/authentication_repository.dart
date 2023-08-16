import 'package:datamex_master_app/app/domain/either.dart';
import 'package:datamex_master_app/app/domain/enums.dart';
import 'package:datamex_master_app/app/domain/models/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
  Future<void> signOut();
  Future<Either<SignInFailure, User>> signIn(String username, String password);
}
