import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:log_in_provider/data/repositories/auth/auth_repository.dart';
import 'package:log_in_provider/data/repositories/profile/profile_repository.dart';
import 'package:log_in_provider/data/services/auth/auth_service.dart';
import 'package:log_in_provider/data/services/profile/profile_service.dart';

Future<void> inject() async {
  //Firebase
  await Firebase.initializeApp().then((firebase) => null);

  // Repositories
  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()), fenix: true);
  Get.lazyPut<AuthService>(() => AuthServiceImpl(FirebaseAuth.instance), fenix: true);

  Get.lazyPut<ProfileRepository>(() => ProfileRepositoryImpl(Get.find()), fenix: true);
  Get.lazyPut<ProfileService>(() => ProfileServiceImpl(FirebaseAuth.instance), fenix: true);
}
