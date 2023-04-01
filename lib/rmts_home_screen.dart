import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_pickup_points.dart';
import 'package:rmts_brts/custom_widgets/custom_bus_card.dart';
import 'package:rmts_brts/custom_widgets/custom_choice_chip.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:rmts_brts/custom_widgets/custom_text_field.dart';
import 'package:rmts_brts/rmts_all_buses.dart';
import 'package:rmts_brts/rmts_all_pickup_points.dart';
import 'package:rmts_brts/rmts_live_bus.dart';
import 'package:rmts_brts/rmts_serach_result.dart';
import 'package:sizer/sizer.dart';

class RMTSHomeScreen extends StatefulWidget {
  const RMTSHomeScreen({Key? key}) : super(key: key);

  @override
  State<RMTSHomeScreen> createState() => _RMTSHomeScreenState();
}

class _RMTSHomeScreenState extends State<RMTSHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? selectedValue = null;
  List<RmtsPickupPoints> rmtsPickupPoints = [];
  List<String> rmtslist = [];
  int fromID = -1;
  int toID = -1;
  var _Loading = true;
  List<String> favPickupPoints = [
    "Madhapar Chowk",
    "GreenLand Chowk",
    "Aaji Dam",
    "Aarya Samaj",
    "Aazad Chowk",
    "Bedi"
  ];

  @override
  void initState() {
    super.initState();
  }

  Future getRmtsPickupPoints() async {
    _Loading = true;
    rmtsPickupPoints.clear();
    rmtslist.clear();

    var response =
        jsonDecode(await BaseClient().get('Rmts/GetAllRmtsPickupPoints'));

    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      for (var t in temp) {
        rmtsPickupPoints.add(RmtsPickupPoints.fromJSON(t));
      }
      for (var r in rmtsPickupPoints) {
        rmtslist.add(r.PickupPointNameEnglish);
      }
      print(rmtslist);
      _Loading = false;
      return rmtsPickupPoints;
    }
    _Loading = false;
    print(response['Message']);
    return [];
  }

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
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 0.5.h, left: 3.5.w, right: 3.5.w),
              child: FutureBuilder(
                future: getRmtsPickupPoints(),
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top: 3.5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                text: "SEARCH ROUTES",
                                fontFamily: 'Poppins',
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2.h),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Autocomplete(
                                            optionsBuilder: (TextEditingValue
                                                textEditingValue) {
                                              if (textEditingValue.text == '') {
                                                return const Iterable<
                                                    String>.empty();
                                              } else {
                                                List<String> matches =
                                                    <String>[];
                                                matches.addAll(rmtslist);
                                                matches.retainWhere((s) {
                                                  return s
                                                      .toLowerCase()
                                                      .contains(textEditingValue
                                                          .text
                                                          .toLowerCase());
                                                });
                                                return matches;
                                              }
                                            },
                                            fieldViewBuilder: (context,
                                                textEditingController,
                                                focusNode,
                                                onFieldSubmitted) {
                                              return CustomTextField(
                                                  text: "FROM",
                                                  textEditingController:
                                                      textEditingController,
                                                  focusNode: focusNode);
                                            },
                                            onSelected: (String selection) {
                                              print(
                                                  'You just selected $selection');
                                              fromID = -1;
                                              for (var i = 0;
                                                  i < rmtsPickupPoints.length;
                                                  i++) {
                                                if (rmtsPickupPoints[i]
                                                        .PickupPointNameEnglish
                                                        .toString()
                                                        .toLowerCase() ==
                                                    selection
                                                        .trim()
                                                        .toLowerCase()) {
                                                  fromID = rmtsPickupPoints[i]
                                                      .PickupPointID;
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Autocomplete(
                                            optionsBuilder: (TextEditingValue
                                                textEditingValue) {
                                              if (textEditingValue.text == '') {
                                                return const Iterable<
                                                    String>.empty();
                                              } else {
                                                List<String> matches =
                                                    <String>[];
                                                matches.addAll(rmtslist);
                                                matches.retainWhere((s) {
                                                  return s
                                                      .toLowerCase()
                                                      .contains(textEditingValue
                                                          .text
                                                          .toLowerCase());
                                                });
                                                return matches;
                                              }
                                            },
                                            fieldViewBuilder: (context,
                                                textEditingController,
                                                focusNode,
                                                onFieldSubmitted) {
                                              return CustomTextField(
                                                  text: "TO",
                                                  textEditingController:
                                                      textEditingController,
                                                  focusNode: focusNode);
                                            },
                                            onSelected: (String selection) {
                                              print(
                                                  'You just selected $selection');
                                              toID = -1;
                                              for (var i = 0;
                                                  i < rmtsPickupPoints.length;
                                                  i++) {
                                                if (rmtsPickupPoints[i]
                                                        .PickupPointNameEnglish
                                                        .toString()
                                                        .toLowerCase() ==
                                                    selection
                                                        .trim()
                                                        .toLowerCase()) {
                                                  toID = rmtsPickupPoints[i]
                                                      .PickupPointID;
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 100,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 0.6.h, left: 12.2.w),
                                      alignment: Alignment.centerLeft,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(35.0.w, 4.5.h),
                                          backgroundColor: const Color.fromARGB(
                                              255, 217, 217, 217),
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0.8.h),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RmtsSearchResult(
                                                      fromID: fromID,
                                                      toID: toID),
                                            ),
                                          );
                                        },
                                        child: CustomText(
                                          text: "Show Result",
                                          fontFamily: 'Poppins',
                                          fontSize: 10.2.sp,
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
                          margin: EdgeInsets.only(top: 3.5.h),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CustomText(
                                      text: "MOST ACTIVE ROUTES",
                                      fontFamily: 'Poppins',
                                      fontSize: 12.5.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 217, 217, 217),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.8.h),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RmtsAllBuses(),
                                          ),
                                        );
                                      },
                                      child: CustomText(
                                        text: "Show More",
                                        fontFamily: 'Poppins',
                                        fontSize: 10.2.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(top: 2.2.h),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      CustomBusCard(
                                        marginRight:
                                            EdgeInsets.only(right: 5.0.w),
                                        busNo: '1',
                                        busText: "Bus No.",
                                        startOfRoute: "Saurashtra University",
                                        endOfRoute: "Trikon Baug",
                                      ),
                                      CustomBusCard(
                                        marginRight:
                                            EdgeInsets.only(right: 5.0.w),
                                        busNo: '12',
                                        busText: "Bus No.",
                                        startOfRoute: "Saurashtra University",
                                        endOfRoute: "Trikon Baug",
                                      ),
                                      const CustomBusCard(
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
                          margin: EdgeInsets.only(top: 3.5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                text: "PICKUP POINTS",
                                fontFamily: 'Poppins',
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2.h),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 2.5.w,
                                  runSpacing: 1.0.h,
                                  children: <Widget>[
                                    for (var fvp in favPickupPoints)
                                      CustomChoiceChip(
                                        text: fvp,
                                        borderColor:
                                            Color.fromARGB(255, 177, 177, 177),
                                        boxColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        textColor:
                                            Color.fromARGB(255, 77, 77, 77),
                                      ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RmtsAllPickupPoints(),
                                          ),
                                        );
                                      },
                                      child: CustomChoiceChip(
                                        text: "Show All",
                                        //marginTop: EdgeInsets.only(top: 6),
                                        borderColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        boxColor:
                                            Color.fromARGB(255, 185, 185, 185),
                                        textColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3.5.h),
                          child: ElevatedButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RmtsLiveBus(),
                                  ))
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(65.0.w, 5.0.h),
                              backgroundColor:
                                  const Color.fromARGB(255, 217, 217, 217),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.8.h),
                              ),
                            ),
                            child: CustomText(
                              text: "Search Live Bus Location",
                              fontFamily: 'Poppins',
                              fontSize: 10.0.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (_Loading) {
                    return CustomLoader();
                  }
                  return Text("Cannot connect to server");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
