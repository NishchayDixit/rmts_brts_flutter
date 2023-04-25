import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_pickup_points.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_pickup_point.dart';
import 'package:sizer/sizer.dart';

class RmtsAllPickupPoints extends StatefulWidget {
  const RmtsAllPickupPoints({Key? key}) : super(key: key);

  @override
  State<RmtsAllPickupPoints> createState() => _RmtsAllPickupPointsState();
}

class _RmtsAllPickupPointsState extends State<RmtsAllPickupPoints> {
  List<RmtsPickupPoints> rmtsPickupPoints = [];
  var _loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 217, 217, 217),
        ),
        child: SafeArea(
          child: Scaffold(
            body: FutureBuilder(
              future: getAllBuses(),
              builder: (context, snapshot) {
                if (snapshot != null && snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                        child: CustomPickupPoint(
                            rmtsPickupPoint: rmtsPickupPoints[index]),
                      );
                    },
                    itemCount: rmtsPickupPoints.length,
                  );
                } else if (_loading) {
                  return CustomLoader();
                }
                return Text("no result found");
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<List> getAllBuses() async {
    _loading = true;
    var response = jsonDecode(await BaseClient()
        .get('Rmts/GetAllRmtsPickupPoints')
        .catchError((err) => {print(err.toString())}));

    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      for (var t in temp) {
        rmtsPickupPoints.add(RmtsPickupPoints.fromJSON(t));
      }
      _loading = false;
      return rmtsPickupPoints;
    }
    print(response['Message']);
    _loading = false;
    return [];
  }
}
