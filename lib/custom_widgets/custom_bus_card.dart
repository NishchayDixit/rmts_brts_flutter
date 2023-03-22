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
    return SizedBox(
      height: 130,
      child: AspectRatio(
        aspectRatio: 9 / 5,
        child: Container(
          padding: const EdgeInsets.all(13),
          margin: marginRight,
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
                      margin: const EdgeInsets.only(top: 5, bottom: 1),
                      child: const Image(
                        image: AssetImage(
                          'assets/icons/vertical_dots.png',
                        ),
                        width: 16,
                        height: 16,
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
        ),
      ),
    );
  }
}
