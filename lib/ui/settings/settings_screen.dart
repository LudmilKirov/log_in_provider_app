import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log_in_provider/data/repositories/profile/profile_repository.dart';
import 'package:log_in_provider/data/services/auth/model/user_model.dart';
import 'package:log_in_provider/res/colors.dart';
import 'package:log_in_provider/res/dimensions.dart';
import 'package:log_in_provider/res/strings/str_keys.dart';
import 'package:log_in_provider/res/styles.dart';
import 'package:log_in_provider/utils/app_util.dart';
import 'package:log_in_provider/utils/ui_utils.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatelessWidget {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final User user;

  SettingsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final profileRepo = Provider.of<ProfileRepository>(context);

    _emailController.text = user.email ?? '';

    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context, profileRepo),
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

  Widget _buildBody(BuildContext context, ProfileRepository profileRepository) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: LogInProviderMargins.medium,
        vertical: LogInProviderMargins.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LogInProviderMargins.large.toSpace(),
          _buildAvatarText(),
          LogInProviderMargins.small.toSpace(),
          _buildAvatarIcon(),
          LogInProviderMargins.large.toSpace(),
          _email(context),
          LogInProviderMargins.large.toSpace(),
          _password(context),
          LogInProviderMargins.medium.toSpace(),
          _buildChangeButton(),
          const Spacer(),
          _buildLogoutRow(profileRepository),
        ],
      ),
    );
  }

  Row _buildLogoutRow(ProfileRepository profileRepository) {
    return Row(
      children: [
        const Spacer(),
        _buildLogoutButton(profileRepository),
      ],
    );
  }

  InkWell _buildChangeButton() {
    return InkWell(
      onTap: () {
        //TODO-ldmil (09/01/2022):TBI
        Get.snackbar('TBI', '');
      },
      child: Text(
        StrKey.changeLabel.tr,
        style: Style.supportTextRegularTextStyle.copyWith(color: ProviderLogInColors.primaryColor),
      ),
    );
  }

  Row _buildAvatarIcon() {
    return Row(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(100.0), child: AppUtil.buildMainImage(user.imageUrl ?? '')),
        LogInProviderMargins.small.toSpace(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.imageUrl ?? 'Selfie.png',
              style: Style.boldNameStyle,
            ),
            LogInProviderMargins.small.toSpace(),
            Text(
              '${StrKey.uploadedLabel.tr} ${_df.format(user.createdAt ?? DateTime.now())}',
              style: Style.supportTextRegularTextStyle,
            )
          ],
        ),
      ],
    );
  }

  Text _buildAvatarText() {
    return Text(
      StrKey.avatarLabel.tr,
      style: Style.supportTextRegularTextStyle.copyWith(color: ProviderLogInColors.grey),
    );
  }

  InkWell _buildLogoutButton(ProfileRepository profileRepository) {
    return InkWell(
      onTap: () async {
        profileRepository.signOut().catchError((error) {
          if (error is FirebaseException) {
            Get.snackbar(StrKey.errorTitle.tr, "${error.message}");
          } else {
            Get.snackbar(StrKey.errorTitle.tr, StrKey.genericErrorLabel.tr);
          }
        });
      },
      child: Container(
        width: Get.width / 2,
        decoration: UiUtils.roundedCorners(),
        child: Padding(
          padding: const EdgeInsets.all(LogInProviderMargins.small),
          child: Center(
            child: Text(
              StrKey.logoutButton.tr,
              style: Style.boldNameStyle.copyWith(color: ProviderLogInColors.white),
            ),
          ),
        ),
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

final DateFormat _df = DateFormat('dd MMM yyyy');
