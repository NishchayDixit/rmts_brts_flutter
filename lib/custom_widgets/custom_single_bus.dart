import 'package:flutter/material.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/Screens/rmts_bus_details.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
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
      height: 11.h,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(4.w, .7.h, 4.w, .7.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryFillColor,
          elevation: .05.h,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.h),
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
              flex: 25,
              child: Container(
                alignment: Alignment.center,
                child: CustomText(
                  text: widget.rmtsResultModel.BusNo.toString() == "null"
                      ? ""
                      : widget.rmtsResultModel.BusNo.toString(),
                  fontFamily: 'Poppins',
                  fontSize: 24.5.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.primaryTextColor,
                ),
              ),
            ),
            Expanded(
              flex: 75,
              child: Container(
                margin: EdgeInsets.only(left: 1.5.w),
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: widget.rmtsResultModel.RouteNameEnglish.toString(),
                  fontFamily: 'Poppins-Regular',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.primaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
