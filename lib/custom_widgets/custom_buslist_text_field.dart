import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/color_constants.dart';

class CustomBusListTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  const CustomBusListTextField({
    Key? key,
    this.textEditingController,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.0.h,
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        cursorColor: ColorConstants.primaryColor,
        style: TextStyle(
          fontSize: 12.0.sp,
          fontFamily: 'Poppins',
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.primaryFillColor,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(1.0.h),
          ),
        ),
        controller: textEditingController,
        focusNode: focusNode,
      ),
    );
  }
}
