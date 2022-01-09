import 'package:flutter/material.dart';
import 'package:log_in_provider/res/colors.dart';

class Style {
  static var appTheme = _generateAppTheme();

  ///this will generate new app theme to be loaded, will refresh primary and accent colors
  ///in future we should be able to load the font as well
  static ThemeData _generateAppTheme() {
    return ThemeData(
      primaryColor: ProviderLogInColors.primaryColor,
      backgroundColor: ProviderLogInColors.appBackground,
      scaffoldBackgroundColor: ProviderLogInColors.appBackground,
    );
  }

  static const TextStyle supportTextRegularTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const boldNameStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
  static const _etBorderSide = BorderSide(color: ProviderLogInColors.appBackground, width: 1);
  static const etBorder = OutlineInputBorder(
    borderSide: _etBorderSide,
    borderRadius: etBorderRadius,
  );
  static const BorderRadius etBorderRadius = BorderRadius.all(Radius.circular(8));
}
