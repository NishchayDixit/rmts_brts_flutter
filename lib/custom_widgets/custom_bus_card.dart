import 'package:flutter/material.dart';
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
      height: 16.2.h,
      child: AspectRatio(
        aspectRatio: 9 / 5,
        child: Container(
          padding: const EdgeInsets.all(13),
          margin: marginRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.5.h),
            color: const Color.fromARGB(255, 245, 245, 245),
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
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w900,
                    ),
                    CustomText(
                      text: busText,
                      fontFamily: 'Poppins',
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 3.5,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: CustomText(
                        text: startOfRoute,
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        textAlignment: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: .7.h, bottom: .7.h),
                      child: Image(
                        image: const AssetImage(
                          'assets/icons/vertical_dots.png',
                        ),
                        width: 2.h,
                        height: 2.h,
                      ),
                    ),
                    CustomText(
                      text: endOfRoute,
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      textAlignment: TextAlign.center,
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
