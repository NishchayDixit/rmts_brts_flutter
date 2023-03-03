import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlignment;
  final TextOverflow? overflow;

  const CustomText({
    Key? key,
    required this.text,
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    this.textAlignment,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlignment,
      overflow: overflow,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
