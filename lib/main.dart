import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'data/injector/injector.dart';
import 'package:log_in_provider/data/repositories/auth/auth_repository.dart';
import 'package:log_in_provider/data/repositories/profile/profile_repository.dart';
import 'package:log_in_provider/res/strings/translations.dart';
import 'package:log_in_provider/res/styles.dart';
import 'ui/explore/explore_screen.dart';
import 'package:log_in_provider/ui/log_in/log_in_screen.dart';
import 'package:log_in_provider/ui/log_in/register/register.dart';
import 'package:log_in_provider/wrapper.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  inject();
  await runMandatoryFutures();

  runApp(ProviderLogInApp());
}

class ProviderLogInApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (_) => AuthRepositoryImpl(Get.find())),
        Provider<ProfileRepository>(create: (_) => ProfileRepositoryImpl(Get.find()))
      ],
      child: GetMaterialApp(
        translations: LogInProviderStrings(),
        locale: const Locale.fromSubtags(languageCode: "en"),
        debugShowCheckedModeBanner: false,
        theme: Style.appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/explore': (context) => ExploreScreen(),
        },
        //   home: SignUpFormPage(),
      ),
    );
  }
}

Future<void> runMandatoryFutures() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
