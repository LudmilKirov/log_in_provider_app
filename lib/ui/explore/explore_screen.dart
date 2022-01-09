import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log_in_provider/data/repositories/auth/auth_repository.dart';
import 'package:log_in_provider/res/colors.dart';
import 'package:log_in_provider/res/dimensions.dart';
import 'package:log_in_provider/res/strings/str_keys.dart';
import 'package:log_in_provider/res/styles.dart';
import 'package:log_in_provider/utils/ui_utils.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
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
        StrKey.exploreButton.tr,
        style: Style.supportTextRegularTextStyle.copyWith(fontSize: 16),
      ),
      backgroundColor: ProviderLogInColors.appBarColor,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBody(BuildContext context, AuthRepository authRepository) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LogInProviderMargins.medium,
        vertical: LogInProviderMargins.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSizedBox(),
          _buildNotLoggedInLabel(),
          _buildSizedBox(),
          LogInProviderMargins.large.toSpace(),
          _email(context),
          LogInProviderMargins.large.toSpace(),
          _password(context),
          LogInProviderMargins.medium.toSpace(),
          _buildChangeButton(),
          const Spacer(),
          _buildLoginButton(authRepository),
        ],
      ),
    );
  }

  Row _buildLoginButton(AuthRepository authRepository) {
    return Row(
      children: [
        const Spacer(),
        _buildLogInButton(authRepository),
      ],
    );
  }

  Center _buildNotLoggedInLabel() {
    return Center(
        child: Text(
      StrKey.notLoggedInLabel.tr,
      style: Style.supportTextRegularTextStyle.copyWith(fontSize: 24),
    ));
  }

  InkWell _buildChangeButton() {
    return InkWell(
      child: Text(
        StrKey.changeLabel.tr,
        style: Style.supportTextRegularTextStyle.copyWith(color: ProviderLogInColors.primaryColor),
      ),
    );
  }

  SizedBox _buildSizedBox() {
    return const SizedBox(
      height: 50,
    );
  }

  InkWell _buildLogInButton(AuthRepository authRepository) {
    return InkWell(
      onTap: () async {
        Get.offAndToNamed('/login');
      },
      child: Container(
        width: Get.width / 2,
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

  Widget _email(BuildContext context) {
    return UiUtils.baseField(
        color: ProviderLogInColors.grey.withOpacity(0.3),
        topText: StrKey.emailTopText.tr,
        child: TextFormField(
          focusNode: _emailFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: _emailController,
          enabled: false,
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
        color: ProviderLogInColors.grey.withOpacity(0.3),
        topText: StrKey.passwordTopText.tr,
        child: TextFormField(
          focusNode: _passwordFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          enabled: false,
          controller: _passwordController,
          decoration: UiUtils.etInputDecoration(
            hint: '********',
          ),
        ));
  }
}
