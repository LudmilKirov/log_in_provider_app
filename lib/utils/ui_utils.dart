import 'package:flutter/material.dart';
import 'package:log_in_provider/res/colors.dart';
import 'package:log_in_provider/res/dimensions.dart';
import 'package:log_in_provider/res/styles.dart';

class UiUtils {
  static InputDecoration etInputDecoration(
      {String? hint,
      Widget? suffixIcon,
      String? prefixText,
      TextStyle? prefixStyle,
      String? suffixText,
      TextStyle? suffixStyle,
      TextStyle? hintTextStyle,
      InputBorder? inputBorder,
      InputBorder? focusedBorder,
      InputBorder? enabledBorder,
      InputBorder? disabledBorder,
      BoxConstraints? suffixIconConstraints,
      Color? suffixIconColor}) {
    return InputDecoration(
        suffixIconColor: suffixIconColor,
        suffixIcon: suffixIcon,
        hintText: hint,
        alignLabelWithHint: true,
        border: inputBorder ?? Style.etBorder,
        prefixText: prefixText,
        prefixStyle: prefixStyle,
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        suffixIconConstraints: suffixIconConstraints,
        enabledBorder: enabledBorder ?? Style.etBorder,
        disabledBorder: disabledBorder ?? Style.etBorder,
        focusedBorder: focusedBorder ?? Style.etBorder);
  }

  static Widget baseField({
    required Widget child,
    String? topText,
    double? width,
    double? height,
    Color? color,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (topText != null)
        Text(
          topText,
          style: Style.supportTextRegularTextStyle.copyWith(color: ProviderLogInColors.black),
        ),
      LogInProviderMargins.small.toSpace(),
      Container(
          width: width ?? double.maxFinite,
          height: height,
          decoration: BoxDecoration(
            color: color ?? ProviderLogInColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(LogInProviderMargins.fieldCorners)),
          ),
          child: Row(
            children: [
              Expanded(
                child: child,
              ),
            ],
          )),
    ]);
  }

  static BoxDecoration roundedCorners({Color? color, Color? borderColor}) {
    return BoxDecoration(
      color: color ?? ProviderLogInColors.primaryColor,
      border: Border.all(
        color: borderColor ?? ProviderLogInColors.primaryColor,
        width: 1.0,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(LogInProviderMargins.fieldCorners)),
    );
  }
}
