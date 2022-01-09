import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log_in_provider/data/repositories/auth/auth_repository.dart';
import 'package:log_in_provider/res/colors.dart';
import 'package:log_in_provider/res/dimensions.dart';
import 'package:log_in_provider/res/strings/str_keys.dart';
import 'package:log_in_provider/res/styles.dart';
import 'package:log_in_provider/utils/ui_utils.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authRepo = Provider.of<AuthRepository>(context);

    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context, authRepo),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(
        StrKey.registerTitle.tr,
      ),
      backgroundColor: ProviderLogInColors.appBarColor,
    );
  }

  Widget _buildBody(BuildContext context, AuthRepository authRepository) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LogInProviderMargins.medium,
        vertical: LogInProviderMargins.large,
      ),
      child: Column(
        children: [
          LogInProviderMargins.large.toSpace(),
          _email(context),
          LogInProviderMargins.large.toSpace(),
          _password(context),
          LogInProviderMargins.large.toSpace(),
          _buildRegisterButton(authRepository),
        ],
      ),
    );
  }

  InkWell _buildRegisterButton(AuthRepository authRepository) {
    return InkWell(
      onTap: () async {
        await _createUser(authRepository);
      },
      child: Container(
        width: Get.width,
        decoration: UiUtils.roundedCorners(),
        child: Padding(
          padding: const EdgeInsets.all(LogInProviderMargins.small),
          child: Center(
            child: Text(
              StrKey.registerButton.tr,
              style: Style.boldNameStyle.copyWith(color: ProviderLogInColors.white),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createUser(AuthRepository authRepository) async {
    await authRepository
        .createUser(_emailController.text, _passwordController.text)
        .then((value) => Get.offAndToNamed('/login'))
        .catchError((error) {
      if (error is FirebaseException) {
        Get.snackbar(StrKey.errorTitle.tr, "${error.message}");
      } else {
        Get.snackbar(StrKey.errorTitle.tr, StrKey.genericErrorLabel.tr);
      }
    });
  }

  Widget _email(BuildContext context) {
    return UiUtils.baseField(
        topText: StrKey.emailTopText.tr,
        child: TextFormField(
          focusNode: _emailFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: _emailController,
          decoration: UiUtils.etInputDecoration(
            hint: StrKey.emailHint.tr,
          ),
          onEditingComplete: () {
            _passwordFocusNode.requestFocus();
          },
        ));
  }

  Widget _password(BuildContext context) {
    return UiUtils.baseField(
        topText: StrKey.passwordTopText.tr,
        child: TextFormField(
          focusNode: _passwordFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: _passwordController,
          obscureText: true,
          obscuringCharacter: '*',
          decoration: UiUtils.etInputDecoration(
            hint: StrKey.passwordHint.tr,
            suffixIcon: const Icon(
              Icons.visibility_off,
              color: ProviderLogInColors.grey,
            ),
          ),
        ));
  }
}
