import 'package:flutter/material.dart';
import 'package:rmts_brts/custom_text.dart';

class CustomChoiceChip extends StatelessWidget {
  final String text;
  final EdgeInsets? marginTop;
  final Color borderColor;
  final Color boxColor;
  final Color textColor;

  const CustomChoiceChip({
    Key? key,
    required this.text,
    this.marginTop,
    required this.borderColor,
    required this.boxColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginTop,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: CustomText(
        overflow: TextOverflow.ellipsis,
        text: text,
        fontFamily: 'Poppins',
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}
