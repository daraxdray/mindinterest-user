import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  const AppStyles._();

  static TextStyle getTextStyle({
    double? fontSize,
    double? letterSpacing,
    Color? color,
    FontStyle? fontStyle,
    TextStyle? textStyle,
    double? wordSpacing,
    TextDecoration? decoration,
    FontWeight? fontWeight,
  }) =>
      GoogleFonts.nunito(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontStyle: fontStyle,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
      );
}
