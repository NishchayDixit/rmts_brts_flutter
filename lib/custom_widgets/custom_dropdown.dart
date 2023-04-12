import 'package:flutter/material.dart';
import 'package:rmts_brts/Model/brts_pickup_points.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomDropDown extends StatefulWidget {
  final String text;
  final FocusNode? focusNode;
  final List<BrtsPickupPoints> brtsPickupPoints;
  dynamic currentSelection;

  CustomDropDown(
      {Key? key,
      required this.text,
      this.focusNode,
      required this.brtsPickupPoints,
      required this.currentSelection})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomText(
            text: widget.text,
            fontFamily: 'Poppins',
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: ColorConstants.primaryTextColor,
          ),
        ),
        SizedBox(width: 4.0.w),
        Expanded(
          flex: 7,
          child: SizedBox(
            height: 5.0.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              decoration: BoxDecoration(
                color: ColorConstants.primaryFillColor,
                borderRadius: BorderRadius.circular(1.0.h),
              ),
              child: widget.brtsPickupPoints.isNotEmpty? DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(1.0.h),

                  isDense: true,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Poppins',
                      fontSize: 12.0.sp,
                      color: Colors.black),
                  alignment: Alignment.topCenter,
                  focusNode: widget.focusNode,
                  items: widget.brtsPickupPoints
                      .map((e) => DropdownMenuItem(
                            value: int.parse(e.BrtsPickupPointID.toString()),
                            child: Text(e.BrtsPickUpPointName),
                          ))
                      .toList(),
                  value: widget.currentSelection["val"],
                  onChanged: (value) {
                    print(value!);
                    setState(() => widget.currentSelection["val"] =
                        int.parse(value.toString()));
                  },
                  // value: "a",
                ),
              ):Container(),
            ),
          ),
        ),
      ],
    );
  }
}
