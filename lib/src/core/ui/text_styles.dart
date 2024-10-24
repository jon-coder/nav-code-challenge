import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get i {
    _instance ??= TextStyles._();
    return _instance!;
  }

  TextStyle get font => GoogleFonts.getFont('Poppins');

  TextStyle get textLight => TextStyle(
        fontWeight: FontWeight.w300,
        fontFamily: font.fontFamily,
      );

  TextStyle get textRegular => TextStyle(
        fontWeight: FontWeight.normal,
        fontFamily: font.fontFamily,
      );

  TextStyle get textMedium => TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: font.fontFamily,
      );

  TextStyle get textSemiBold => TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: font.fontFamily,
      );

  TextStyle get textBold => TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: font.fontFamily,
      );

  TextStyle get textExtraBold => TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: font.fontFamily,
      );

  TextStyle get textButtonLabel => textBold.copyWith(
        fontSize: 14,
      );

  TextStyle get textTitle => textExtraBold.copyWith(
        fontSize: 28,
      );
}

extension TextStylesExtensions on BuildContext {
  TextStyles get textStyles => TextStyles.i;
}
