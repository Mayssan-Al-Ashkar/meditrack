import 'package:flutter/material.dart';

extension TextThemeCompat on TextTheme {
  // Provide compatibility getters for older TextTheme names that were removed
  // in newer Flutter versions (headline6, bodyText1, etc.) by mapping to the
  // current counterpart names. Return non-nullable TextStyle with empty default
  TextStyle get headline6 => this.headlineSmall ?? const TextStyle();
  TextStyle get bodyText1 => this.bodyLarge ?? const TextStyle();
  TextStyle get bodyText2 => this.bodyMedium ?? const TextStyle();
  TextStyle get subtitle1 => this.titleMedium ?? const TextStyle();
  TextStyle get subtitle2 => this.titleSmall ?? const TextStyle();
  TextStyle get headline1 => this.displayLarge ?? const TextStyle();
  TextStyle get headline2 => this.displayMedium ?? const TextStyle();
  TextStyle get headline3 => this.displaySmall ?? const TextStyle();
  TextStyle get headline4 => this.headlineLarge ?? const TextStyle();
  TextStyle get headline5 => this.headlineMedium ?? const TextStyle();
}
