import 'package:flutter/material.dart';
import 'package:rmts_brts/Model/rmts_pickup_points.dart';

class CustomPickupPoint extends StatefulWidget {
  final RmtsPickupPoints rmtsPickupPoint;
  const CustomPickupPoint({Key? key, required this.rmtsPickupPoint}) : super(key: key);

  @override
  State<CustomPickupPoint> createState() => _CustomPickupPointState();
}

class _CustomPickupPointState extends State<CustomPickupPoint> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 217, 217, 217),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () {

        },
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
                width: 30,
                child: Icon(Icons.location_on),
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
                    )),
              ),
            ),
            Expanded(
              flex: 20,
              child: Container(
                alignment: Alignment.centerRight,
                width: 30.0,
                child: Icon(Icons.navigate_next_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
