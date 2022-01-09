import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:log_in_provider/data/services/auth/model/user_model.dart';

abstract class AuthService {
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUser(String email, String password);
  Future<void> signOut();
  Stream<User?>? get user;
}

class AuthServiceImpl extends AuthService {
  final auth.FirebaseAuth _firebaseAuth;

  AuthServiceImpl(this._firebaseAuth);

  User? userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }

    return User(uid: user.uid, email: user.email, createdAt: user.metadata.creationTime, imageUrl: user.photoURL);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userFromFirebase(credential.user);
  }

  Future<User?> createUser(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    return userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
