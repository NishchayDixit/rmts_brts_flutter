import 'dart:ui';
import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');
  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color primaryColor = const Color.fromARGB(255, 64, 95, 223);
  static Color seconderyColor = const Color.fromARGB(255, 127, 151, 255);
  static Color primaryTextColor = const Color.fromARGB(255, 43, 69, 179);
  static Color seconderyTextColor = const Color.fromARGB(255, 0, 0, 0);
  static Color primaryAccentTextColor = const Color.fromARGB(255, 255, 255, 255);
  static Color primaryFillColor = const Color.fromARGB(255, 239, 242, 254);
  static Color primaryBackGround = const Color.fromARGB(255, 207, 207, 207);
  static Color shadowColor = const Color.fromARGB(255, 190, 190, 190);
  static Color buttonColor = const Color.fromRGBO(240, 51, 74, 1);
  static Color kSecondaryBackgroundColor = const Color.fromRGBO(107, 82, 200, 0.1);
  static Color kPrimaryBackgroundColor = Colors.deepOrange;
}
