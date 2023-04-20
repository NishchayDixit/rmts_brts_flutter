import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rmts_brts/Model/rmts_live_bus_model.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class RmtsLiveBus extends StatefulWidget {
  const RmtsLiveBus({super.key});

  @override
  State<RmtsLiveBus> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RmtsLiveBus> {
  TextEditingController textEditingController = TextEditingController();
  late Future<List<RmtsLiveBusModel>> futureBus;
  int busfoundcount = 0;
  int bus_no = -1;
  bool isLoading = false;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset:
              false, // backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 6.5.h,
                  margin: EdgeInsets.only(bottom: 1.5.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: ColorConstants.primaryColor,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.start,
                          controller: textEditingController,
                          textAlignVertical: TextAlignVertical.bottom,
                          cursorColor: ColorConstants.primaryColor,
                          decoration: InputDecoration(
                            // filled: true,
                            // fillColor: ColorConstants.primaryFillColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(1.0.h),
                            ),
                            hintText: "Enter Bus no.",
                            hintStyle: TextStyle(
                                fontSize: 15.5,
                                color: ColorConstants.seconderyColor),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // if(!isLoading){
                          setState(() {
                            bus_no = int.parse(
                                textEditingController.text.toString());
                            buses;
                            // fetchBus();
                          });
                          // }
                        },
                        enableFeedback: true,
                        child: Ink(
                          color: ColorConstants.primaryColor,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            child: Text(
                              "Search",
                              style: TextStyle(
                                color: ColorConstants.primaryAccentTextColor,
                                // fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: (bus_no != -1)
                      ? FutureBuilder<List<RmtsLiveBusModel>>(
                          future: fetchBus(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return SingleBus(buses[index]);
                                },
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data?.length,
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            } else if (isLoading) {
                              return CustomLoader();
                            } else if (!isLoading && busfoundcount == 0) {
                              return Text("no buses found.");
                            }
                            // By default, show a loading spinner.
                            return Center(
                                child: const CircularProgressIndicator());
                          },
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SingleBus(RmtsLiveBusModel b) {
    GeoPoint currpoint = GeoPoint(
        latitude: double.parse(b.Latitude),
        longitude: double.parse(b.Longitude));
    MapController bmc = MapController(
      initMapWithUserPosition: false,
      initPosition: currpoint,
    );
    return Container(
      margin: EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1.h,
            spreadRadius: 1.5,
            offset: const Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(1.5.h),
        ),
      ),
      // height: 200,
      child: Column(
        children: [
          //Maps
          Stack(
            children: [
              Container(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 6 / 3,
                  child: OSMFlutter(
                    controller: bmc,
                    initZoom: 15.0,
                    onMapIsReady: (p0) {
                      bmc.addMarker(currpoint,
                          markerIcon: MarkerIcon(
                            icon: Icon(Icons.location_on_rounded, size: 80),
                          ));
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      MapsLauncher.launchCoordinates(
                          double.parse(b.Latitude), double.parse(b.Longitude));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 1.5.h, left: 1.5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0.sp),
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/icon_google_maps.png',
                            width: 16,
                            fit: BoxFit.fitWidth,
                          ),
                          CustomText(
                            text: "  Maps",
                            fontFamily: 'Poppins',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      setState(() {
                        b.A_BusNo;
                        bus_no;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0.sp),
                        ),
                        color: ColorConstants.primaryColor,
                      ),
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: CustomText(
                        text: "Refresh",
                        fontFamily: 'Poppins',
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.h),
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0.sp),
                  ),
                ),
                margin: EdgeInsets.all(6.0.sp),
                child: CustomText(
                  text: b.A_BusNo.toString(),
                  fontFamily: 'Poppins',
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              CustomText(
                text: 'Status: ${b.VehicleStatus}',
                fontFamily: 'Poppins',
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              SizedBox(width: 5.w),
              CustomText(
                text: 'Speed: ${b.Speed}',
                fontFamily: 'Poppins',
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ],
          )
        ],
      ),
    );
  }

  List<RmtsLiveBusModel> buses = [];

  Future<List<RmtsLiveBusModel>> fetchBus() async {
    isLoading = true;
    buses.clear();
    busfoundcount = 0;
    final response = await http
        .get(Uri.parse('http://www.rajkotrajpath.com/get_location.php'));
    if (response.statusCode == 200) {
      List<dynamic> d_buses = List.from(jsonDecode(response.body));

      for (var d_bus in d_buses) {
        if (d_bus['VehName']
            .toString()
            .toLowerCase()
            .contains("Route No".toLowerCase())) {
          var temp = "Route No ".toLowerCase().length;
          d_bus['A_BusNo'] = int.parse(d_bus['VehName'].toString().substring(
              d_bus['VehName']
                      .toString()
                      .toLowerCase()
                      .indexOf("Route No".toLowerCase()) +
                  temp,
              d_bus['VehName']
                      .toString()
                      .toLowerCase()
                      .indexOf("Route No".toLowerCase()) +
                  temp +
                  2));
          // print(d_bus['A_BusNo']);
          if (d_bus['A_BusNo'] == int.parse(bus_no.toString())) {
            busfoundcount++;
            buses.add(RmtsLiveBusModel.fromJSON(d_bus));
          }
        }
      }

      // print(buses.length);
      isLoading = false;
      return buses;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}
