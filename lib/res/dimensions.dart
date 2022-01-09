import 'package:flutter/material.dart';

class LogInProviderMargins {
  static const double xSmall = 8.0;
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 20.0;
  static const double extraLarge = 32.0;

  /// Main corners rounds
  static const double fieldCorners = 10.0;

  LogInProviderMargins._();
}

extension MarginExtensions on double {
  Widget toSpace({bool horizontally = true, bool vertically = true}) {
    assert(horizontally != false || vertically != false);
    return SizedBox(
      width: horizontally ? this : 0,
      height: vertically ? this : 0,
    );
  }
}
