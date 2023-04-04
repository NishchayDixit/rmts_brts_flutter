import 'package:flutter/material.dart';
import 'package:rmts_brts/Model/rmts_pickup_points.dart';
import 'package:rmts_brts/rmts_buses_pickup.dart';
import 'package:sizer/sizer.dart';

import '../config/color_constants.dart';

class CustomPickupPoint extends StatefulWidget {
  final RmtsPickupPoints rmtsPickupPoint;

  const CustomPickupPoint({Key? key, required this.rmtsPickupPoint})
      : super(key: key);

  @override
  State<CustomPickupPoint> createState() => _CustomPickupPointState();
}

class _CustomPickupPointState extends State<CustomPickupPoint> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(1.0.w, 1.0.h, 1.0.w, 1.0.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryAccentTextColor,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RmtsBusesPickup(rmtsPickupPoint: widget.rmtsPickupPoint),
              ));
        },
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
                width: 30,
                child:
                    Icon(Icons.location_on, color: ColorConstants.primaryColor),
              ),
            ),
            Expanded(
              flex: 70,
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                    widget.rmtsPickupPoint.PickupPointNameEnglish.toString(),
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.seconderyTextColor,
                    )),
              ),
            ),
            Expanded(
              flex: 20,
              child: Container(
                alignment: Alignment.centerRight,
                width: 30.0,
                child: Icon(
                  Icons.navigate_next_rounded,
                  color: ColorConstants.seconderyTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
