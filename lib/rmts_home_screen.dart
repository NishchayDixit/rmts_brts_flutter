import 'package:flutter/material.dart';
import 'package:rmts_brts/custom_widgets/custom_bus_card.dart';
import 'package:rmts_brts/custom_widgets/custom_choice_chip.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:rmts_brts/custom_widgets/custom_text_field.dart';
import 'homepage.dart';

class RMTSHomeScreen extends StatefulWidget {
  const RMTSHomeScreen({Key? key}) : super(key: key);

  @override
  State<RMTSHomeScreen> createState() => _RMTSHomeScreenState();
}

class _RMTSHomeScreenState extends State<RMTSHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CustomText(
                          text: "SEARCH ROUTES",
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Column(
                                children: const <Widget>[
                                  CustomTextField(text: 'FROM'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(text: 'TO'),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
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
                        Row(
                          children: [
                            Expanded(child: Container(),),
                            Expanded(
                              flex: 100,
                              child: Container(
                                margin: const EdgeInsets.only(top: 5, left: 44),
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(120.54, 34),
                                    backgroundColor:
                                    const Color.fromARGB(255, 217, 217, 217),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const CustomText(
                                    text: "Show Result",
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const CustomText(
                                text: "MOST ACTIVE ROUTES",
                                fontFamily: 'Poppins',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromARGB(255, 217, 217, 217),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyHomePage(),
                                    ),
                                  );
                                },
                                child: const CustomText(
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
                              children: const <Widget>[
                                CustomBusCard(
                                  marginRight: EdgeInsets.only(right: 25),
                                  busNo: '1',
                                  busText: "Bus No.",
                                  startOfRoute: "Saurashtra University",
                                  endOfRoute: "Trikon Baug",
                                ),
                                CustomBusCard(
                                  marginRight: EdgeInsets.only(right: 25),
                                  busNo: '12',
                                  busText: "Bus No.",
                                  startOfRoute: "Saurashtra University",
                                  endOfRoute: "Trikon Baug",
                                ),
                                CustomBusCard(
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
                    margin: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CustomText(
                          text: "PICKUP POINTS",
                          fontFamily: 'Poppins',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 6.0,
                            children: const <Widget>[
                              CustomChoiceChip(
                                text: "Madhapar Chowk",
                                borderColor: Color.fromARGB(255, 177, 177, 177),
                                boxColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 77, 77, 77),
                              ),
                              CustomChoiceChip(
                                text: "GreenLand Chowk",
                                borderColor: Color.fromARGB(255, 177, 177, 177),
                                boxColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 77, 77, 77),
                              ),
                              CustomChoiceChip(
                                text: "AajiDam",
                                borderColor: Color.fromARGB(255, 177, 177, 177),
                                boxColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 77, 77, 77),
                              ),
                              CustomChoiceChip(
                                text: "AaryaSamaj",
                                marginTop: EdgeInsets.only(top: 6),
                                borderColor: Color.fromARGB(255, 177, 177, 177),
                                boxColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 77, 77, 77),
                              ),
                              CustomChoiceChip(
                                text: "Aazad Chowk",
                                marginTop: EdgeInsets.only(top: 6),
                                borderColor: Color.fromARGB(255, 177, 177, 177),
                                boxColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 77, 77, 77),
                              ),
                              CustomChoiceChip(
                                text: "Bedi",
                                marginTop: EdgeInsets.only(top: 6),
                                borderColor: Color.fromARGB(255, 177, 177, 177),
                                boxColor: Color.fromARGB(255, 255, 255, 255),
                                textColor: Color.fromARGB(255, 77, 77, 77),
                              ),
                              CustomChoiceChip(
                                text: "Show All",
                                marginTop: EdgeInsets.only(top: 6),
                                borderColor: Color.fromARGB(255, 255, 255, 255),
                                boxColor: Color.fromARGB(255, 185, 185, 185),
                                textColor: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ],
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
    );
  }
}
