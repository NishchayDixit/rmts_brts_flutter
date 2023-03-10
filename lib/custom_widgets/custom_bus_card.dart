import 'package:flutter/material.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';

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
    return Container(

      padding: const EdgeInsets.all(13),
      margin: marginRight,
      height: 102,
      width: 195,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
                CustomText(
                  text: busText,
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: CustomText(
                    text: startOfRoute,
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    textAlignment: TextAlign.center,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("|", style: TextStyle(fontSize: 18.0),),
                    ],
                  ),
                ),
                CustomText(
                  text: endOfRoute,
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  textAlignment: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
