import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log_in_provider/data/repositories/auth/auth_repository.dart';
import 'package:log_in_provider/res/colors.dart';
import 'package:log_in_provider/res/dimensions.dart';
import 'package:log_in_provider/res/strings/str_keys.dart';
import 'package:log_in_provider/res/styles.dart';
import 'package:log_in_provider/utils/ui_utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen();

  @override
  Widget build(BuildContext context) {
    final authRepo = Provider.of<AuthRepository>(context);

    return Scaffold(
      backgroundColor: ProviderLogInColors.appBackground,
      body: _buildBody(context, authRepo),
    );
  }

  Widget _buildBody(BuildContext context, AuthRepository authRepository) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LogInProviderMargins.medium,
            vertical: LogInProviderMargins.large,
          ),
          child: Column(
            children: [
              _buildHeight100Box(),
              _buildWelcomeText(),
              LogInProviderMargins.large.toSpace(),
              _email(context),
              LogInProviderMargins.large.toSpace(),
              _password(context),
              LogInProviderMargins.large.toSpace(),
              _buildLoginButton(authRepository),
              LogInProviderMargins.extraLarge.toSpace(),
              _buildRegisterButton(),
              LogInProviderMargins.large.toSpace(),
              _buildOrRow(),
              LogInProviderMargins.large.toSpace(),
              _buildExploreButton(),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox _buildHeight100Box() {
    return const SizedBox(
      height: 100,
    );
  }

  Center _buildWelcomeText() {
    return Center(
        child: Text(
      StrKey.welcomeLabel.tr,
      style: Style.supportTextRegularTextStyle.copyWith(fontSize: 24),
    ));
  }

  Row _buildOrRow() {
    return Row(
      children: [
        _buildDivider(),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: LogInProviderMargins.small, end: LogInProviderMargins.small),
          child: Text(
            StrKey.orLabel.tr,
            style: Style.supportTextRegularTextStyle.copyWith(color: ProviderLogInColors.grey),
          ),
        ),
        _buildDivider()
      ],
    );
  }

  Widget _buildExploreButton() {
    return InkWell(
      onTap: () {
        Get.toNamed('/explore');
      },
      child: Container(
          width: Get.width,
          decoration: UiUtils.roundedCorners(
              color: ProviderLogInColors.white, borderColor: ProviderLogInColors.grey.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(LogInProviderMargins.small),
            child: Center(
              child: Text(
                StrKey.exploreButton.tr,
                style: Style.supportTextRegularTextStyle.copyWith(fontSize: 16),
              ),
            ),
          )),
    );
  }

  InkWell _buildRegisterButton() {
    return InkWell(
      onTap: () {
        Get.toNamed('/register');
      },
      child: Text(
        StrKey.registerButton.tr,
        style: Style.supportTextRegularTextStyle
            .copyWith(color: ProviderLogInColors.primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  InkWell _buildLoginButton(AuthRepository authRepository) {
    return InkWell(
      onTap: () async {
        await _signInWithEmail(authRepository);
      },
      child: Container(
        width: Get.width,
        decoration: UiUtils.roundedCorners(),
        child: Padding(
          padding: const EdgeInsets.all(LogInProviderMargins.small),
          child: Center(
            child: Text(
              StrKey.loginButton.tr,
              style: Style.boldNameStyle.copyWith(color: ProviderLogInColors.white),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmail(AuthRepository authRepository) async {
    await authRepository
        .signInWithEmailAndPassword(_emailController.text, _passwordController.text)
        .then((value) => Get.offAllNamed('/'))
        .catchError((error) {
      if (error is FirebaseException) {
        Get.snackbar(StrKey.errorTitle.tr, "${error.message}");
      } else {
        Get.snackbar(StrKey.errorTitle.tr, StrKey.genericErrorLabel.tr);
      }
    });
  }

  Expanded _buildDivider() {
    return const Expanded(
      child: Divider(
        color: ProviderLogInColors.grey,
        thickness: 1,
      ),
    );
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
