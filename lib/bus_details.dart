import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_pickup_points.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_pickup_point.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';

class BusDetails extends StatefulWidget {
  final RmtsResultModel rmtsResultModel;

  const BusDetails({Key? key, required this.rmtsResultModel}) : super(key: key);

  @override
  State<BusDetails> createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails>
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            // margin: const EdgeInsets.only(top: 20.0),
            // height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 15.0),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back_rounded, size: 24),
                        ),
                        Text(widget.rmtsResultModel.BusNo == null
                            ? ""
                            : "" + widget.rmtsResultModel.BusNo.toString()),
                        Text("-"),
                        Text(widget.rmtsResultModel.RouteNameEnglish),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    // height: 50,
                    width: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 230, 230),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: TabBar(
                            indicatorColor: Colors.white,
                            indicatorWeight: 2,
                            indicatorPadding: EdgeInsets.all(1.0),
                            indicator: BoxDecoration(
                              color: Color.fromARGB(255, 185, 185, 185),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            controller: tabController,
                            tabs: [
                              Tab(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: Icon(Icons.access_time),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: CustomText(
                                          text: "Timings",
                                          fontFamily: 'Poppins',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  children: const <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: Icon(Icons.location_on_rounded),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: CustomText(
                                          text: "Points",
                                          fontFamily: 'Poppins',
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.normal),
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
                    children: [customTimingView(), customPickupPointsView()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTimingView() {
    return Container(

      child: FutureBuilder(
        future: getTimings(widget.rmtsResultModel),
        builder: (context, snapshot) {
          if (snapshot != null && snapshot.hasData) {
            List<String> timingsAm = [];
            List<String> timingsPm = [];
            for(var i=0;i<snapshot.data!.length;i++){
              if(snapshot.data![i]["TimeDisplay"].toString().toLowerCase().contains("am")){
                timingsAm.add(snapshot.data![i]["TimeDisplay"]);
              }else{
                timingsPm.add(snapshot.data![i]["TimeDisplay"]);
              }
            }
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Morning To Noon"),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            print(snapshot.data);
                            return Container(
                              child: Text(timingsAm[index]),
                            );
                          },
                          shrinkWrap: true,
                          itemCount:timingsAm.length,
                        ),                    ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Text("Noon To Afternoon"),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            print(snapshot.data);
                            return Container(
                              child: Text(timingsPm[index]),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: timingsPm.length,
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            );
          }
          return Text("no result found");
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
            for(var t in snapshot.data!){
              pickuppoints.add(RmtsPickupPoints.fromJSON(t));
            }

            return Padding(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CustomPickupPoint(rmtsPickupPoint: pickuppoints[index]);
                },
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:snapshot.data!.length,
              ),
            );
          }else if(_loading){
            return CustomLoader();
          }
          return Text("no result found");
        },
      ),
    );
  }

  Future<List> getTimings(RmtsResultModel rmtsResultModel) async {
    _loading=true;
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
