import 'package:flutter/material.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomBusCard extends StatelessWidget {
  final String busNo;
  final String busText;
  final String startOfRoute;
  final String endOfRoute;
  final EdgeInsets? marginRight;

  const CustomBusCard({
    Key? key,
    required this.busNo,
    required this.busText,
    required this.startOfRoute,
    required this.endOfRoute,
    this.marginRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 19.2.h,
      child: AspectRatio(
        aspectRatio: 9 / 5.5,
        child: Container(
          padding: EdgeInsets.all(.5.h),
          margin: marginRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.5.h),
            // color: const Color.fromARGB(255, 245, 245, 245),
            gradient: LinearGradient(begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [ColorConstants.primaryColor,const Color.fromARGB(
                  255, 103, 130, 255),],),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: busNo,
                      fontFamily: 'Poppins',
                      fontSize: 26.0.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: busText,
                      fontFamily: 'Poppins',
                      fontSize: 11.0.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 2.2.w,
              // ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: CustomText(
                        text: startOfRoute,
                        fontFamily: 'Poppins',
                        fontSize: 11.0.sp,
                        fontWeight: FontWeight.w700,
                        textAlignment: TextAlign.center,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: .7.h, bottom: .7.h),
                      child: Image(
                        image: const AssetImage(
                          'assets/icons/vertical_dots.png',
                        ),
                        color: Colors.white,
                        // width: 2.h,
                        height: 2.h,
                      ),
                    ),
                    CustomText(
                      text: endOfRoute,
                      fontFamily: 'Poppins',
                      fontSize: 11.0.sp,
                      fontWeight: FontWeight.w700,
                      textAlignment: TextAlign.center,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
