import 'package:flutter/material.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:rmts_brts/rmts_bus_details.dart';
import 'package:sizer/sizer.dart';

class CustomSingleBus extends StatefulWidget {
  final RmtsResultModel rmtsResultModel;

  const CustomSingleBus({Key? key, required this.rmtsResultModel})
      : super(key: key);

  @override
  State<CustomSingleBus> createState() => _CustomSingleBusState();
}

class _CustomSingleBusState extends State<CustomSingleBus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9.h,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(3.w, .5.h, 3.w, .5.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryAccentTextColor,
          elevation: .25.h,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.h),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RmtsBusDetails(rmtsResultModel: widget.rmtsResultModel),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
              flex: 15,
              child: Container(
                alignment: Alignment.center,
                child: CustomText(
                  text: widget.rmtsResultModel.BusNo.toString() == "null"
                      ? ""
                      : widget.rmtsResultModel.BusNo.toString(),
                  fontFamily: 'Poppins',
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ),
            Expanded(
              flex: 73,
              child: Container(
                margin: EdgeInsets.only(left: 1.5.w),
                alignment: Alignment.centerLeft,
                // child: Text(
                //   widget.rmtsResultModel.RouteNameEnglish.toString(),
                //   // overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //     fontSize: 14,
                //   ),
                // ),
                child: CustomText(
                  text: widget.rmtsResultModel.RouteNameEnglish.toString(),
                  fontFamily: 'Poppins-Regular',
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.seconderyTextColor,
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.navigate_next_rounded, color: ColorConstants.seconderyTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
