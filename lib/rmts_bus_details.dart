import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_pickup_points.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_pickup_point.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class RmtsBusDetails extends StatefulWidget {
  final RmtsResultModel rmtsResultModel;

  const RmtsBusDetails({Key? key, required this.rmtsResultModel})
      : super(key: key);

  @override
  State<RmtsBusDetails> createState() => _RmtsBusDetailsState();
}

class _RmtsBusDetailsState extends State<RmtsBusDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var _loading = true;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 1.5.h),
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(6.0.w, 2.5.h, 6.0.w, 2.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 10,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 24,
                          color: ColorConstants.primaryAccentTextColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 90,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            CustomText(
                                text: widget.rmtsResultModel.BusNo == null
                                    ? ""
                                    : "${widget.rmtsResultModel.BusNo}",
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                color: ColorConstants.primaryAccentTextColor,
                                fontWeight: FontWeight.w600),
                            CustomText(
                                text: " - ",
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                color: ColorConstants.primaryAccentTextColor,
                                fontWeight: FontWeight.w600),
                            Expanded(
                              child: CustomText(
                                text: widget.rmtsResultModel.RouteNameEnglish,
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                color: ColorConstants.primaryAccentTextColor,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Container(
                // height: 50,
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: ColorConstants.seconderyColor,
                  borderRadius: BorderRadius.circular(20.h),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(.6.h),
                      child: TabBar(
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(20.h),
                        ),
                        controller: tabController,
                        tabs: [
                          Tab(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Icon(
                                    Icons.access_time,
                                    color:
                                        ColorConstants.primaryAccentTextColor,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: CustomText(
                                    text: "Timings",
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        ColorConstants.primaryAccentTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color:
                                        ColorConstants.primaryAccentTextColor,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: CustomText(
                                    text: "Points",
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        ColorConstants.primaryAccentTextColor,
                                  ),
                                )
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
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  customTimingView(),
                  customPickupPointsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTimingView() {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
        future: getTimings(widget.rmtsResultModel),
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.hasData) {
            List<String> timingsAm = [];
            List<String> timingsPm = [];
            for (var i = 0; i < snapshot.data!.length; i++) {
              if (snapshot.data![i]["TimeDisplay"]
                  .toString()
                  .toLowerCase()
                  .contains("am")) {
                timingsAm.add(snapshot.data![i]["TimeDisplay"]);
              } else {
                timingsPm.add(snapshot.data![i]["TimeDisplay"]);
              }
            }
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 1.0.h),
                      child: Column(
                        children: [
                          // Text("Morning To Noon"),
                          Container(
                            padding: EdgeInsets.only(
                              top: 1.0.h,
                              bottom: 1.0.h,
                              right: 4.0.w,
                              left: 4.0.w,
                            ),
                            margin: EdgeInsets.only(top: .5.h, bottom: .5.h),
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
                              text: "Morning To Noon",
                              fontFamily: "Poppins",
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ListView.builder(
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              print(snapshot.data);
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
                                padding:
                                    EdgeInsets.only(top: 1.0.h, bottom: 1.0.h),
                                margin:
                                    EdgeInsets.only(top: .5.h, bottom: .5.h),
                                alignment: Alignment.center,
                                child: CustomText(
                                  text: timingsAm[index],
                                  fontFamily: 'Poppins',
                                  fontSize: 11.5.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: timingsAm.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // margin: EdgeInsets.only(left: .5.h),
                      padding: EdgeInsets.only(left: .5.h),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 1.0.h,
                                bottom: 1.0.h,
                                right: 2.0.w,
                                left: 2.0.w),
                            margin: EdgeInsets.only(top: .5.h, bottom: .5.h),
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
                              text: "Noon To Afternoon",
                              fontFamily: "Poppins",
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                // print(snapshot.data);
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
                                  padding:
                                      EdgeInsets.symmetric(vertical: 1.0.h),
                                  margin: EdgeInsets.symmetric(
                                      vertical: .5.h, horizontal: .5.w),
                                  alignment: Alignment.center,
                                  child: CustomText(
                                    text: timingsPm[index],
                                    fontFamily: 'Poppins',
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              itemCount: timingsPm.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }

  Widget customPickupPointsView() {
    return Container(
      child: FutureBuilder(
        future: getPickupPoints(widget.rmtsResultModel),
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.hasData) {
            List<RmtsPickupPoints> pickuppoints = [];
            for (var t in snapshot.data!) {
              pickuppoints.add(RmtsPickupPoints.fromJSON(t));
            }

            return Padding(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CustomPickupPoint(
                      rmtsPickupPoint: pickuppoints[index]);
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
              ),
            );
          } else if (_loading) {
            return CustomLoader();
          }
          return Text("no result found");
        },
      ),
    );
  }

  Future<List> getTimings(RmtsResultModel rmtsResultModel) async {
    _loading = true;
    var response = jsonDecode(await BaseClient().post(
        'Rmts/GetRmtsSelectTime', {
      "id": widget.rmtsResultModel.RouteID.toString()
    }).catchError((err) => {print(err.toString())}));

    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      // setState(() {

      // });
      print(temp);
      _loading = false;
      return temp;
      // print(rmtsResultModel.toString());
    }
    print(response['Message']);
    _loading = false;
    return [];
  }

  Future<List> getPickupPoints(RmtsResultModel rmtsResultModel) async {
    var response = jsonDecode(await BaseClient().post(
        'Rmts/GetRmtsPickupPointRoutewise', {
      "id": widget.rmtsResultModel.RouteID.toString()
    }).catchError((err) => {print(err.toString())}));

    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      // setState(() {
      //   _loading = false;
      // });
      print(temp);
      return temp;
      // print(rmtsResultModel.toString());
    }
    print(response['Message']);
    return [];
  }
}
