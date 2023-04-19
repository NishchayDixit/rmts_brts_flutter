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
  static Color primaryColor = hexToColor('#405FDF');
  static Color seconderyColor = hexToColor('#7F97FF');
  static Color primaryTextColor = hexToColor('#2B45B3');
  static Color seconderyTextColor = hexToColor('#000000');
  static Color primaryAccentTextColor = hexToColor('#ffffff');
  static Color primaryFillColor = hexToColor('#EFF2FE');
  static Color primaryBackGround = hexToColor('#CFCFCF');
  static Color shadowColor = hexToColor('#BEBEBE');
}
