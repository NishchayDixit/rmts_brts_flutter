import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rmts_brts/Model/rmts_live_bus_model.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
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
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: ColorConstants.primaryColor,
                          width: 2.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 65,
                          child: TextField(
                            textAlign: TextAlign.start,
                            controller: textEditingController,
                            textAlignVertical: TextAlignVertical.bottom,
                            cursorColor: ColorConstants.primaryColor,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: ColorConstants.primaryFillColor,
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
                        Expanded(
                          flex: 35,
                          child: InkWell(
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
                                alignment: Alignment.center,
                                height: double.maxFinite,
                                width: double.maxFinite,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                child: Text(
                                  "Search",
                                  style: TextStyle(
                                    color:
                                        ColorConstants.primaryAccentTextColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 94,
                  child: (bus_no != -1)
                      ? FutureBuilder<List<RmtsLiveBusModel>>(
                          future: fetchBus(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data?.length != 0) {
                              return Column(
                                children: [
                                  // Text(buses.length.toString()),
                                  ListView.builder(
                                    itemBuilder: (context, index) {
                                      return SingleBus(buses[index]);
                                    },
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data?.length,
                                  ),
                                ],
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
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      // height: 200,
      child: Column(
        children: [
          //Maps
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                    "https://maps.rmtsbus.in/?lat=" +
                        b.Latitude +
                        "&lon=" +
                        b.Longitude,
                    fit: BoxFit.fill),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      MapsLauncher.launchCoordinates(
                          double.parse(b.Latitude), double.parse(b.Longitude));
                    },
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(top: 15, left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.fromLTRB(8, 10, 4, 10),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/icon_google_maps.png',
                            width: 16,
                            fit: BoxFit.fitWidth,
                          ),
                          Text('  Maps',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
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
                          Radius.circular(5),
                        ),
                        color: Color.fromARGB(255, 210, 210, 210),
                      ),
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: Text('Refresh'),
                    ),
                  )
                ],
              ),
            ],
          ),
          Text(b.A_BusNo.toString()),
          Text(
            b.ResponseStatus.toString(),
          ),
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
