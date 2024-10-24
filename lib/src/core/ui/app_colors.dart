import 'package:flutter/material.dart';

class AppColors {
  static const _defaultGray = 0xFF4A4A4A;
  static const _defaultPrimary = 0xFFB13325;

  static const MaterialColor gray = MaterialColor(_defaultGray, <int, Color>{
    0: Color(0xFFF2F2F2),
    10: Color(0xFFE0E0E0),
    20: Color(0xFFBDBDBD),
    30: Color(0xFF9E9E9E),
    40: Color(0xFF808080),
    50: Color(0xFF616161),
    60: Color(_defaultGray),
    70: Color(0xFF424242),
    80: Color(0xFF3B3B3B),
    90: Color(0xFF2A2A2A),
    100: Color(0xFF000000),
  });

  static const MaterialColor primary = MaterialColor(
    _defaultPrimary,
    <int, Color>{
      0: Color(0xFFFFE3E0),
      10: Color(0xFFFFC2B2),
      20: Color(0xFFFFA69A),
      30: Color(0xFFFF8A7A),
      40: Color(0xFFFF6F6F),
      50: Color(_defaultPrimary),
      60: Color(0xFF9B2620),
      70: Color(0xFF851F1A),
      80: Color(0xFF6F1A15),
      90: Color(0xFF5A1410),
      100: Color(0xFF3D0E0B),
    },
  );
}
