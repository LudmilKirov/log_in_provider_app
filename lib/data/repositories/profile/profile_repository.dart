import 'package:log_in_provider/data/services/profile/profile_service.dart';

abstract class ProfileRepository {
  Future<void> signOut();
}

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileService _service;

  ProfileRepositoryImpl(this._service);

  @override
  Future<void> signOut() {
    return _service.signOut();
  }
}
