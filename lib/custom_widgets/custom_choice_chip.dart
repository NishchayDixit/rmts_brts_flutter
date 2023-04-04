import 'package:flutter/material.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomChoiceChip extends StatelessWidget {
  final String text;
  final EdgeInsets? marginTop;
  final Color boxColor;
  final Color textColor;

  const CustomChoiceChip({
    Key? key,
    required this.text,
    this.marginTop,
    required this.boxColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginTop,
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.0.w),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(1.2.h),
      ),
      child: CustomText(
        overflow: TextOverflow.ellipsis,
        text: text,
        fontFamily: 'Poppins',
        fontSize: 9.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}
