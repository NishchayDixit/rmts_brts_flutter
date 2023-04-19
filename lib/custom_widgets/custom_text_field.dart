import 'package:flutter/material.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  const CustomTextField(
      {Key? key,
      required this.text,
      this.textEditingController,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textEditingController!.text = "";
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomText(
            text: text,
            fontFamily: 'Poppins',
            fontSize: 10.5.sp,
            fontWeight: FontWeight.w700,
            color: ColorConstants.primaryTextColor,
          ),
        ),
        SizedBox(width: 4.0.w),
        Expanded(
          flex: 6,
          child: SizedBox(
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
          ),
        ),
      ],
    );
  }
}
