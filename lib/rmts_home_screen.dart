// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class RMTS_HomeScreen extends StatefulWidget {
  const RMTS_HomeScreen({Key? key}) : super(key: key);

  @override
  State<RMTS_HomeScreen> createState() => _RMTS_HomeScreenState();
}

class _RMTS_HomeScreenState extends State<RMTS_HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 83,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/container_bg.png'),
                        fit: BoxFit.fill),
                  ),
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    body: Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 26),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                customText(
                                  text: 'RMTS',
                                  fontFamily: 'Poppins',
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                customText(
                                  text: "Rajkot Mass Transport Service",
                                  fontFamily: 'Poppins',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                customText(
                                  text: "SEARCH ROUTES",
                                  fontFamily: 'Poppins',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: Column(
                                        children: <Widget>[
                                          customTextField(text: 'FROM'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          customTextField(text: 'TO'),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 70,
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 30,
                                            child: SizedBox(
                                              height: 44 + 44,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  "assets/icons/icon_swap.png",
                                                  width: 36,
                                                  height: 36,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, left: 44),
                                  alignment: Alignment.centerLeft,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(120.54, 34),
                                      backgroundColor: const Color.fromARGB(
                                          255, 217, 217, 217),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: customText(
                                      text: "Show Result",
                                      fontFamily: 'Poppins',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 27),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      customText(
                                        text: "MOST ACTIVE ROUTES",
                                        fontFamily: 'Poppins',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(95, 30),
                                          backgroundColor: const Color.fromARGB(
                                              255, 217, 217, 217),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: customText(
                                          text: "Show More",
                                          fontFamily: 'Poppins',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: const EdgeInsets.only(top: 15),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        customBusCard(
                                          marginRight:
                                              const EdgeInsets.only(right: 25),
                                          busNo: '1',
                                          busText: "Bus No.",
                                          startOfRoute: "Saurashtra University",
                                          endOfRoute: "Trikon Baug",
                                        ),
                                        customBusCard(
                                          marginRight:
                                              const EdgeInsets.only(right: 25),
                                          busNo: '12',
                                          busText: "Bus No.",
                                          startOfRoute: "Saurashtra University",
                                          endOfRoute: "Trikon Baug",
                                        ),
                                        customBusCard(
                                          busNo: '55',
                                          busText: "Bus No.",
                                          startOfRoute: "Saurashtra University",
                                          endOfRoute: "Trikon Baug",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(top: 27),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                customText(
                                  text: "PICKUP POINTS",
                                  fontFamily: 'Poppins',
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Flexible(
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 6.0,
                                      children: <Widget>[
                                        customChoiceChip(
                                          text: "Madhapar Chowk",
                                          borderColor: const Color.fromARGB(
                                              255, 177, 177, 177),
                                          boxColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          textColor: const Color.fromARGB(
                                              255, 77, 77, 77),
                                        ),
                                        customChoiceChip(
                                          text: "GreenLand Chowk",
                                          borderColor: const Color.fromARGB(
                                              255, 177, 177, 177),
                                          boxColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          textColor: const Color.fromARGB(
                                              255, 77, 77, 77),
                                        ),
                                        customChoiceChip(
                                          text: "AajiDam",
                                          borderColor: const Color.fromARGB(
                                              255, 177, 177, 177),
                                          boxColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          textColor: const Color.fromARGB(
                                              255, 77, 77, 77),
                                        ),
                                        customChoiceChip(
                                          text: "AaryaSamaj",
                                          marginTop:
                                              const EdgeInsets.only(top: 6),
                                          borderColor: const Color.fromARGB(
                                              255, 177, 177, 177),
                                          boxColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          textColor: const Color.fromARGB(
                                              255, 77, 77, 77),
                                        ),
                                        customChoiceChip(
                                          text: "Aazad Chowk",
                                          marginTop:
                                              const EdgeInsets.only(top: 6),
                                          borderColor: const Color.fromARGB(
                                              255, 177, 177, 177),
                                          boxColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          textColor: const Color.fromARGB(
                                              255, 77, 77, 77),
                                        ),
                                        customChoiceChip(
                                          text: "Bedi",
                                          marginTop:
                                              const EdgeInsets.only(top: 6),
                                          borderColor: const Color.fromARGB(
                                              255, 177, 177, 177),
                                          boxColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          textColor: const Color.fromARGB(
                                              255, 77, 77, 77),
                                        ),
                                        customChoiceChip(
                                          text: "Show All",
                                          marginTop:
                                              const EdgeInsets.only(top: 6),
                                          borderColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          boxColor: const Color.fromARGB(
                                              255, 185, 185, 185),
                                          textColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 17,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: <Widget>[
                      customText(
                        text: "BRTS",
                        fontFamily: 'Poppins',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      customText(
                        text: "Swipe up or click here",
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //region CUSTOM-TEXT-FIELD_WIDGET

  Widget customTextField({required text}) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: customText(
                text: text,
                fontFamily: 'Poppins',
                fontSize: 12.0,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 8,
            child: SizedBox(
              height: 39,
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 248, 248, 248),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //endregion

  //region CUSTOM-TEXT-WIDGET

  Widget customText({
    required text,
    required fontFamily,
    required fontSize,
    required fontWeight,
    color,
    textAlignment,
    overflow,
  }) {
    return Text(
      text,
      textAlign: textAlignment,
      overflow: overflow,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  //endregion

  //region CUSTOM-BUS-CARD-WIDGET

  Widget customBusCard({
    required busNo,
    required busText,
    required startOfRoute,
    required endOfRoute,
    marginRight,
  }) {
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
                customText(
                  text: busNo,
                  fontFamily: 'Poppins',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
                customText(
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
                  child: customText(
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
                      'assets/icons/verticale_dots.png',
                    ),
                    width: 16,
                    height: 16,
                  ),
                ),
                customText(
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

  //endregion

  //region CUSTOM-CHOICE-CHIP

  Widget customChoiceChip(
      {required text,
      marginTop,
      required borderColor,
      required boxColor,
      required textColor}) {
    return Container(
      margin: marginTop,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: customText(
        overflow: TextOverflow.ellipsis,
        text: text,
        fontFamily: 'Poppins',
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

//endregion
}