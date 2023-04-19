import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_pickup_points.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_single_bus.dart';

class RmtsBusesPickup extends StatefulWidget {
  final RmtsPickupPoints rmtsPickupPoint;
  const RmtsBusesPickup({Key? key,required this.rmtsPickupPoint}) : super(key: key);

  @override
  State<RmtsBusesPickup> createState() => _RmtsBusesPickupState();
}

class _RmtsBusesPickupState extends State<RmtsBusesPickup> {
  List<RmtsResultModel> rmtsResultModel = [];
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
          color: const Color.fromARGB(255, 207, 207, 207),
        ),
        child: SafeArea(
          child: Scaffold(
            body: Container(
              width: double.infinity,
              child: FutureBuilder(
                future: getAllBuses(),
                builder: (context, snapshot) {
                  if (snapshot != null && snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      addAutomaticKeepAlives: true,
                      itemBuilder: (context, index) {
                        return CustomSingleBus(
                            rmtsResultModel: rmtsResultModel[index]);
                      },
                      itemCount: rmtsResultModel.length,
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
      ),
    );
  }

  Future<List> getAllBuses() async {
    _loading = true;
    var obj = {
      "id": widget.rmtsPickupPoint.PickupPointID.toString(),
    };
    var response = jsonDecode(await BaseClient()
        .post('Rmts/GetRmtsPickupRoutewiseRoute', obj)
        .catchError((err) => {print(err.toString())}));

    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      for (var t in temp) {
        rmtsResultModel.add(RmtsResultModel.fromJSON(t));
      }
      _loading = false;
      return rmtsResultModel;
    }
    print(response['Message']);
    _loading = false;
    return [];
  }

}
