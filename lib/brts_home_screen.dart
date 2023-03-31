import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/brts_pickup_points.dart';
import 'package:rmts_brts/Model/brts_route_details.dart';
import 'package:rmts_brts/custom_widgets/custom_dropdown.dart';
import 'package:rmts_brts/custom_widgets/custom_expansion_tile.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';

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
  List<String> brtslist = [];
  var fromID = {"val": -1};
  var toID = {"val": -1};
  bool _Loading = true;

  @override
  void initState() {
    super.initState();
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 10.0),
              child: FutureBuilder(
                future: getBrtsPickupPoints(),
                builder: (context, snapshot) {
                  snapshot.connectionState == ConnectionState.waiting;
                  if (snapshot.data != null && snapshot.hasData) {
                    fromID["val"] = fromPickupPoints[0].BrtsPickupPointID;
                    toID["val"] = toPickupPoints[0].BrtsPickupPointID;
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
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
                                              brtsPickupPoints:
                                                  fromPickupPoints,
                                              currentSelection: fromID,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
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
                                    onPressed: () {
                                      print(fromID.toString() +
                                          "->" +
                                          toID.toString());
                                      getBrtsRoute(
                                          fromID: fromID["val"],
                                          toID: toID["val"]);
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
                          ),
                        ),
                        // if(brtsSearchResult.isNotEmpty)
                          Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,

                                  itemBuilder: (context, index) {
                                    return CustomExpansionTile(
                                        brtsPickUpPointName: brtsSearchResult[index].BrtsPickUpPointName,
                                        brtsRouteDetails: brtsSearchResultDetails[index]);
                                  },
                                  shrinkWrap: true,
                                  itemCount: brtsSearchResult.isNotEmpty ? brtsSearchResult.length:0,
                                ),
                            ),
                        // else Container(),

                        // Container(
                        //   alignment: Alignment.topLeft,
                        //   margin: const EdgeInsets.only(top: 30),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       const CustomText(
                        //         text: "PICKUP POINTS",
                        //         fontFamily: 'Poppins',
                        //         fontSize: 15.0,
                        //         fontWeight: FontWeight.w700,
                        //       ),
                        //       Container(
                        //         margin: const EdgeInsets.only(top: 10),
                        //         child: Wrap(
                        //           alignment: WrapAlignment.start,
                        //           spacing: 10.0,
                        //           runSpacing: 10.0,
                        //           children: <Widget>[
                        //             CustomChoiceChip(
                        //               text: "Madhapar Chowk",
                        //               borderColor:
                        //                   Color.fromARGB(255, 177, 177, 177),
                        //               boxColor:
                        //                   Color.fromARGB(255, 255, 255, 255),
                        //               textColor:
                        //                   Color.fromARGB(255, 77, 77, 77),
                        //             ),
                        //             CustomChoiceChip(
                        //               text: "GreenLand Chowk",
                        //               borderColor:
                        //                   Color.fromARGB(255, 177, 177, 177),
                        //               boxColor:
                        //                   Color.fromARGB(255, 255, 255, 255),
                        //               textColor:
                        //                   Color.fromARGB(255, 77, 77, 77),
                        //             ),
                        //             CustomChoiceChip(
                        //               text: "AajiDam",
                        //               borderColor:
                        //                   Color.fromARGB(255, 177, 177, 177),
                        //               boxColor:
                        //                   Color.fromARGB(255, 255, 255, 255),
                        //               textColor:
                        //                   Color.fromARGB(255, 77, 77, 77),
                        //             ),
                        //             CustomChoiceChip(
                        //               text: "AaryaSamaj",
                        //               marginTop: EdgeInsets.only(top: 6),
                        //               borderColor:
                        //                   Color.fromARGB(255, 177, 177, 177),
                        //               boxColor:
                        //                   Color.fromARGB(255, 255, 255, 255),
                        //               textColor:
                        //                   Color.fromARGB(255, 77, 77, 77),
                        //             ),
                        //             CustomChoiceChip(
                        //               text: "Aazad Chowk",
                        //               marginTop: EdgeInsets.only(top: 6),
                        //               borderColor:
                        //                   Color.fromARGB(255, 177, 177, 177),
                        //               boxColor:
                        //                   Color.fromARGB(255, 255, 255, 255),
                        //               textColor:
                        //                   Color.fromARGB(255, 77, 77, 77),
                        //             ),
                        //             CustomChoiceChip(
                        //               text: "Bedi",
                        //               marginTop: EdgeInsets.only(top: 6),
                        //               borderColor:
                        //                   Color.fromARGB(255, 177, 177, 177),
                        //               boxColor:
                        //                   Color.fromARGB(255, 255, 255, 255),
                        //               textColor:
                        //                   Color.fromARGB(255, 77, 77, 77),
                        //             ),
                        //             CustomChoiceChip(
                        //               text: "Show All",
                        //               marginTop: EdgeInsets.only(top: 6),
                        //               borderColor:
                        //                   Color.fromARGB(255, 255, 255, 255),
                        //               boxColor:
                        //                   Color.fromARGB(255, 185, 185, 185),
                        //               textColor:
                        //                   Color.fromARGB(255, 255, 255, 255),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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

  Future<List<BrtsPickupPoints>> getBrtsPickupPoints() async {
    _Loading = true;
    fromPickupPoints.clear();
    brtslist.clear();
    var response =
        jsonDecode(await BaseClient().get('Brts/GetAllBrtsPickupPoints'));
    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      for (var t in temp) {
        fromPickupPoints.add(BrtsPickupPoints.fromJSON(t));
      }
      for (var b in fromPickupPoints) {
        brtslist.add(b.BrtsPickUpPointName);
        // print(b.BrtsPickupPointID);
      }
      List<BrtsPickupPoints> fromtemp, totemp;
      fromtemp = [];
      totemp = [];
      for (var e in fromPickupPoints) {
        if (e.BrtsPickupPointID == 1 || e.BrtsPickupPointID == 18) {
          totemp.add(e);
          // toPickupPoints.add(e);
          // fromPickupPoints.remove(e);
        } else {
          fromtemp.add(e);
        }
      }
      toPickupPoints = totemp;
      fromPickupPoints = fromtemp;
      // print(response['ResultList']);
      print(fromPickupPoints.toString());
      // print(toPickupPoints.toString());
      _Loading = false;
      return fromPickupPoints;
    }
    print(response['Message']);
    _Loading = false;
    return [];
  }
}
