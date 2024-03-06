import 'package:flutter/material.dart';

class AssetsImg {
  static const logo = 'assets/img/logo.jpg';
  static const face = 'assets/img/face.jpg';
  static const shopBanner = 'assets/img/shop-banner.jpg';
  static const iconFace = 'assets/icon/face.svg';
  static const iconDrop = 'assets/icon/drop.svg';
}

final ThemeData appTheme = ThemeData(
  fontFamily: 'NotoSansKR',
  // primaryColor: const Color(0xFF8ED0CA),
  primaryColor: const Color(0xFFFF6693),
  secondaryHeaderColor: const Color(0xFF4ACCC2),
  primaryColorDark: const Color(0xff48426D),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'NotoSansKR',
      fontWeight: FontWeight.w600,
      fontSize: 60,
      color: Color(0xff48426D),
      height: 1,
    ),
    titleMedium: TextStyle(
      fontFamily: 'NotoSansKR',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Colors.black,
      height: 0.8,
    ),
    titleSmall: TextStyle(
      fontFamily: 'NotoSansKR',
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Color(0xFF5A5A5A),
      height: 0.8,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.black87,
      fontFamily: 'NotoSansKR',
      height: 1.3,
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      color: Color(0xFF666666),
      fontFamily: 'NotoSansKR',
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Color(0xFF666666),
      fontFamily: 'NotoSansKR',
    ),
    displayLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Color(0xff333333),
      fontFamily: 'NotoSansKR',
    ),
    displayMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xff48426D),
      fontFamily: 'NotoSansKR',
    ),
    displaySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xff666666),
      fontFamily: 'NotoSansKR',
      height: 1.4,
    ),
  ),
);
