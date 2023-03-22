import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';

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
    () async {
      var response = jsonDecode(await BaseClient().post(
          'Rmts/GetRmtsSelectTime', {
        "id": widget.rmtsResultModel.RouteID
      }).catchError((err) => {print(err.toString())}));

      if (response['IsResult'] == 1) {
        List<dynamic> temp = List.from(response['ResultList']);

        setState(() {
          _loading = false;
        });
        print(response['ResultList']);
        // print(rmtsResultModel.toString());
      } else {
        print(response['Message']);
      }
    }();
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
                            tabs: const [
                              Tab(
                                icon: Icon(Icons.access_time),
                                text: 'Timings',
                              ),
                              Tab(
                                icon: Icon(Icons.location_on_rounded),
                                text: 'Pickup points',
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
                    children: const [Text("Hello"), Text("World")],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget customTimingView(){
    return Container(

    );
  }
}
