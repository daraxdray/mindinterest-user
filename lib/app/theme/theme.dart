// ignore_for_file: one_member_abstracts

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  ThemeData getTheme();
}

class AppLightTheme extends AppTheme {
  @override
  ThemeData getTheme() {
    return _themeData(themeMode: ThemeMode.light);
  }
}

class AppDarkTheme extends AppTheme {
  @override
  ThemeData getTheme() {
    return _themeData(themeMode: ThemeMode.dark);
  }
}

const kWhite = Color(0xFFFFFFFF);
const kBlack = Color(0xFF000000);

const kLightGrey = Color(0xFF807E7E);
const kDarkGrey = Color(0xFF333333);

const kPrimaryColor = Color(0xFF3F91F5);
const kPrimaryDark = Color(0xFF084A9B);
const kPrimaryVariantColor = Color(0xFF3F91F5);

const kSecondaryColor = Color(0xFFF4BF6F);
const kSecondaryDark = Color(0xFFAB6C0D);

const kSecondaryVariantColor = Color(0xFFFFC401);

const kErrorColor = Color(0xFFF2190D);

const kSuccessColor = Color(0xFF00BA88);
const kWarningColor = Color(0xFFFFE65F);

//Grey Scale Colors

const kTitleActiveColor = Color(0xFF14142B);
const kBodyColor = Color(0xFF4E4B66);
const kLabelColor = Color(0xFF6E7191);
const kPlaceHolderColor = Color(0xFF6E7191);

const kLineColor = Color(0xFFD6D8E7);
const kInputBGColor = Color(0xFFD6D8E7);
const kBgColor = Color(0xFFF7F7FC);
const kOffWhite = Color(0xFFD6D8E7);

class DarkScheme extends ColorScheme {
  const DarkScheme.dark() : super.dark();
}

class LightScheme extends ColorScheme {
  const LightScheme.light() : super.light();
}

const ColorScheme _colorScheme = ColorScheme(
  primary: kPrimaryColor,
  secondary: kSecondaryColor,
  surface: kWhite,
  error: kErrorColor,
  onSecondary: kBlack,
  onBackground: kDarkGrey,
  onSurface: kLightGrey,
  background: kWhite,
  onError: kWhite,
  onPrimary: kWhite,
  brightness: Brightness.light,
);

const ColorScheme _darkColorScheme = ColorScheme(
  primary: kSecondaryColor,
  secondary: kSecondaryColor,
  surface: kDarkGrey,
  error: kErrorColor,
  onSecondary: kWhite,
  onBackground: kLightGrey,
  onSurface: kDarkGrey,
  background: kDarkGrey,
  onError: kWhite,
  onPrimary: kWhite,
  brightness: Brightness.dark,
);

TextTheme _textTheme(ColorScheme colorScheme) {
  final isDark = colorScheme.brightness == Brightness.dark;
  return TextTheme(
    headline1: GoogleFonts.nunito(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: colorScheme.onBackground,
    ),
    headline2: GoogleFonts.nunito(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
    ),

    /// [subtite1] is used to style TextFields label text
    subtitle1: GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSecondary,
    ),
    subtitle2: GoogleFonts.nunito(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: colorScheme.onBackground,
    ),
    bodyText1: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: colorScheme.onBackground,
    ),
    bodyText2: GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: isDark ? kLightGrey : colorScheme.onSurface,
    ),
    caption: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: colorScheme.onSurface,
    ),
    button: TextStyle(
      fontSize: 16,
      color: colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    ),
  );
}

ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
  return ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    colorScheme: colorScheme,
    height: 48,
    minWidth: double.infinity,
  );
}

InputDecorationTheme _inputDecorationTheme(
  TextTheme textTheme,
  ColorScheme colorScheme,
) {
  return InputDecorationTheme(
    border: InputBorder.none,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.error, width: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.error, width: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.onSurface, width: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.onSecondary),
      borderRadius: BorderRadius.circular(4),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.onSurface, width: 0.5),
      borderRadius: BorderRadius.circular(5),
    ),
    contentPadding: const EdgeInsets.all(16),
  );
}

ThemeData _themeData({required ThemeMode themeMode}) {
  switch (themeMode) {
    case ThemeMode.dark:
      const colorScheme = _darkColorScheme;
      return ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(elevation: 0),
        colorScheme: colorScheme,
        textTheme: _textTheme(colorScheme),
        buttonTheme: _buttonThemeData(colorScheme),
        inputDecorationTheme:
            _inputDecorationTheme(_textTheme(colorScheme), colorScheme),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        backgroundColor: colorScheme.background,
        primaryColor: colorScheme.primary,
        errorColor: colorScheme.error,
        primaryColorLight: colorScheme.primaryContainer,
      );
    case ThemeMode.light:
      const colorScheme = _colorScheme;
      return ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(elevation: 0),
        colorScheme: colorScheme,
        textTheme: _textTheme(colorScheme),
        buttonTheme: _buttonThemeData(colorScheme),
        inputDecorationTheme:
            _inputDecorationTheme(_textTheme(colorScheme), colorScheme),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        backgroundColor: colorScheme.background,
        primaryColor: colorScheme.primary,
        errorColor: colorScheme.error,
        primaryColorLight: colorScheme.primaryContainer,
      );
    case ThemeMode.system:
      return ThemeData();
  }
}
