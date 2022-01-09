import 'package:log_in_provider/data/services/auth/auth_service.dart';
import 'package:log_in_provider/data/services/auth/model/user_model.dart';

abstract class AuthRepository {
  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<User?> createUser(String email, String password);

  Stream<User?>? get user;
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<User?> createUser(String email, String password) {
    return _service.createUser(email, password);
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) {
    return _service.signInWithEmailAndPassword(email, password);
  }

  @override
  Stream<User?>? get user => _service.user;
}
