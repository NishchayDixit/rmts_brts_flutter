import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/brts_pickup_points.dart';
import 'package:rmts_brts/Model/brts_route_details.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_dropdown.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class BRTSHomeScreen extends StatefulWidget {
  const BRTSHomeScreen({Key? key}) : super(key: key);

  @override
  State<BRTSHomeScreen> createState() => _BRTSHomeScreenState();
}

class _BRTSHomeScreenState extends State<BRTSHomeScreen> {
  List<BrtsPickupPoints> fromPickupPoints = [];
  List<BrtsPickupPoints> toPickupPoints = [];
  List<BrtsPickupPoints> brtsSearchResult = [];
  List<BrtsRouteDetails> brtsSearchResultDetails = [];
  var fromID = {"val": -1};
  var toID = {"val": -1};
  bool _Loading = true;
  bool _showResult = false;
  List<String> timings = [];
  bool _fromnow = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(top: 10.0),
        child: FutureBuilder(
          future: getBrtsPickupPoints(),
          builder: (context, snapshot) {
            // snapshot.connectionState == ConnectionState.waiting;
            if (snapshot.data != null && snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
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
                          Container(
                            margin: const EdgeInsets.only(top: 14),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: CustomDropDown(
                                        text: "FROM",
                                        brtsPickupPoints: fromPickupPoints,
                                        currentSelection: fromID,
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
                                      child: CustomDropDown(
                                        text: "To",
                                        brtsPickupPoints: toPickupPoints,
                                        currentSelection: toID,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ), //Show Result Button.
                          Row(
                            children: [
                              Checkbox(
                                value: _fromnow,
                                onChanged: (value) {
                                  setState(() {
                                    _fromnow = value!;
                                  });
                                },
                                checkColor: ColorConstants.primaryFillColor,
                              ),
                              CustomText(
                                  text: "From Now",
                                  fontFamily: "Poppins",
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400),
                              Container(
                                margin:
                                    EdgeInsets.only(top: 0.6.h, left: 14.9.w),
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(35.0.w, 4.5.h),
                                    backgroundColor:
                                        ColorConstants.primaryColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.8.h),
                                    ),
                                  ),
                                  onPressed: () {
                                    print(fromID.toString() +
                                        "->" +
                                        toID.toString());
                                    setState(() {
                                      _showResult = true;
                                    });
                                    // }();
                                  },
                                  child: const CustomText(
                                    text: "Show Result",
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _showResult ? customTimingView() : Container(),
                ],
              );
            } else if (_Loading) {
              return CustomLoader();
            }
            return Text("Cannot connect to server");
          },
        ),
      ),
    );
  }

  Widget customTimingView() {
    timings.clear();
    return FutureBuilder(
      future: _fromnow
          ? getTimingsFromNow(
              fromID: fromID["val"]!, toID: toID["val"]!, time: getCurrTime())
          : getTimings(fromID: fromID["val"]!, toID: toID["val"]!),
      builder: (context, snapshot) {
        if (snapshot != null && snapshot.hasData) {
          for (var i = 0; i < snapshot.data!.length; i++) {
            timings.add(snapshot.data![i]["time"]);
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              padding: EdgeInsets.only(left: .5.h),
              child: Column(
                children: [
                  FutureBuilder(
                    future: getBrtsDetails(
                        fromID: fromID["val"], toID: toID["val"]),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot != null && snapshot.hasData) {
                        return Container(
                          child: getCard(
                              distance: "${snapshot.data?.BrtsDistance} km.",
                              fare: "₹ ${snapshot.data?.BrtsFare}/-",
                              duration:
                                  "${snapshot.data?.BrtsTravellingTime} mins"),
                        );
                      }
                      return Container();
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 1.0.h, bottom: 1.0.h, right: 2.0.w, left: 2.0.w),
                    margin: EdgeInsets.only(top: 2.5.h, bottom: 1.5.h),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 1,
                          color: ColorConstants.shadowColor,
                        )
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(1.0.h),
                      ),
                      color: ColorConstants.primaryFillColor,
                    ),
                    child: CustomText(
                      text: "Bus Timings",
                      fontFamily: "Poppins",
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 20.0.h,
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 1.5,
                          crossAxisSpacing: 1.w,
                          mainAxisSpacing: 0.5.h),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 1,
                                color: ColorConstants.shadowColor,
                              )
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(1.0.h),
                            ),
                            color: ColorConstants.primaryAccentTextColor,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 1.0.h),
                          margin: EdgeInsets.symmetric(
                              vertical: .5.h, horizontal: .5.w),
                          alignment: Alignment.center,
                          child: CustomText(
                            text: timings[index],
                            fontFamily: 'Poppins',
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        );
                      },
                      itemCount: timings.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CustomText(
            text: "No Result Found",
            fontFamily: "Poppins",
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w300,
          ),
        );
      },
    );
  }

  Future<List> getTimings({required int fromID, required int toID}) async {
    _Loading = true;
    brtsSearchResult.clear();
    brtsSearchResultDetails.clear();
    var response = jsonDecode(await BaseClient().post(
        'Brts/GetBrtsGetTimings', {
      "fromID": fromID.toString(),
      "toID": toID.toString()
    }).catchError((err) => {print(err.toString())}));

    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      print(temp);
      _Loading = false;
      return temp;
    }
    print(response['Message']);
    _Loading = false;
    return [];
  }

  Future<List> getTimingsFromNow(
      {required int fromID, required int toID, required int time}) async {
    _Loading = true;
    var response = jsonDecode(await BaseClient().post(
        'Brts/GetBrtsGetTimingsNow', {
      "fromID": fromID.toString(),
      "toID": toID.toString(),
      "time": time.toString()
    }).catchError((err) => {print(err.toString())}));

    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      print(temp);
      _Loading = false;
      return temp;
    }
    print(response['Message']);
    _Loading = false;
    return [];
  }

  Widget getCard({fare, distance, duration}) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        // color: Colors.black87,
        padding: const EdgeInsets.all(30),
        child: Table(
          children: [
            TableRow(children: [
              CustomText(
                text: "Fare",
                fontFamily: 'Poppins',
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w300,
                color: ColorConstants.primaryAccentTextColor,
              ),
              CustomText(
                text: ":",
                fontFamily: 'Poppins',
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w300,
                color: ColorConstants.primaryAccentTextColor,
              ),
              CustomText(
                text: fare,
                fontFamily: 'Poppins',
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w300,
                color: ColorConstants.primaryAccentTextColor,
              ),
            ]),
            TableRow(
              children: [
                CustomText(
                  text: "Distance",
                  fontFamily: 'Poppins',
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w300,
                  color: ColorConstants.primaryAccentTextColor,
                ),
                // CustomText(text: "Duration", fontFamily: "Poppins", fontSize: 20, fontWeight: FontWeight.w400),
                // Text("Duration"),
                CustomText(
                  text: ":",
                  fontFamily: 'Poppins',
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w300,
                  color: ColorConstants.primaryAccentTextColor,
                ),
                CustomText(
                  text: distance,
                  fontFamily: 'Poppins',
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w300,
                  color: ColorConstants.primaryAccentTextColor,
                ),
              ],
            ),
            TableRow(
              children: [
                CustomText(
                  text: "Duration",
                  fontFamily: 'Poppins',
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w300,
                  color: ColorConstants.primaryAccentTextColor,
                ),
                CustomText(
                  text: ":",
                  fontFamily: 'Poppins',
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w300,
                  color: ColorConstants.primaryAccentTextColor,
                ),
                CustomText(
                  text: duration,
                  fontFamily: 'Poppins',
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w300,
                  color: ColorConstants.primaryAccentTextColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getBrtsRoute({required fromID, required toID}) async {
    _Loading = true;
    brtsSearchResult.clear();
    var obj = {
      "fromID": fromID.toString(),
      "toID": toID.toString(),
    };
    var response = jsonDecode(await BaseClient()
        .post('Brts/GetBrtsRouteFromTo', obj)
        .catchError((err) => {print(err.toString())}));

    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      for (var t in temp) {
        print(t);
        BrtsRouteDetails? brtsRouteDetails = await getBrtsDetails(
            fromID: fromID,
            toID: BrtsPickupPoints.fromJSON(t).BrtsPickupPointID);
        brtsSearchResult.add(BrtsPickupPoints.fromJSON(t));
        brtsSearchResultDetails.add(brtsRouteDetails!);
      }
      print(temp);
      setState(() {
        brtsSearchResult;
      });
      print("searchReuslt" + brtsSearchResult.toString());
      _Loading = false;
    }
    print(response['Message']);

    _Loading = false;
  }

  Future<BrtsRouteDetails?> getBrtsDetails(
      {required fromID, required toID}) async {
    _Loading = true;
    print("$fromID->$toID");
    var obj = {
      "fromID": fromID.toString(),
      "toID": toID.toString(),
    };
    var response = jsonDecode(await BaseClient()
        .post('Brts/GetBrtsRouteDetails', obj)
        .catchError((err) => {print(err.toString())}));

    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);
      print(response['ResultList']);
      _Loading = false;
      return BrtsRouteDetails.fromJSON(temp[0]);
    }
    print(response['Message']);
    _Loading = false;
    return null;
  }

  int getCurrTime() {
    var time = int.parse(
        TimeOfDay.now().hour.toString() + TimeOfDay.now().minute.toString());
    return time;
  }

  Future<List<BrtsPickupPoints>> getBrtsPickupPoints() async {
    _Loading = true;
    fromPickupPoints.clear();
    toPickupPoints.clear();
    fromPickupPoints.add(
      const BrtsPickupPoints(
          BrtsPickupPointID: -1, BrtsPickUpPointName: "Select Point"),
    );
    toPickupPoints.add(
      const BrtsPickupPoints(
          BrtsPickupPointID: -1, BrtsPickUpPointName: "Select Point"),
    );
    var response =
        jsonDecode(await BaseClient().get('Brts/GetAllBrtsPickupPoints'));
    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);
      for (var t in temp) {
        toPickupPoints.add(BrtsPickupPoints.fromJSON(t));
        fromPickupPoints.add(BrtsPickupPoints.fromJSON(t));
      }
      print(fromPickupPoints.toString());
      _Loading = false;
      return fromPickupPoints;
    }
    print(response['Message']);
    _Loading = false;
    return [];
  }
}
