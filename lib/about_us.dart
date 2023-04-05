import 'package:flutter/material.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CustomText(
          text: "About Us",
          fontFamily: 'Poppins',
          fontSize: 14.0.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
