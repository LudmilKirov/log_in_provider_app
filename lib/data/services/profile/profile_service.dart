import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class ProfileService {
  Future<void> signOut();
}

class ProfileServiceImpl extends ProfileService {
  final auth.FirebaseAuth _firebaseAuth;

  ProfileServiceImpl(this._firebaseAuth);

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
