import 'package:flutter/material.dart';
import 'package:log_in_provider/data/repositories/auth/auth_repository.dart';
import 'package:log_in_provider/data/services/auth/model/user_model.dart';
import 'package:log_in_provider/ui/log_in/log_in_screen.dart';
import 'package:log_in_provider/ui/settings/settings_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authRepository = Provider.of<AuthRepository>(context);

    return StreamBuilder<User?>(
        stream: authRepository.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? LoginScreen() : SettingsScreen(user: user,);
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
