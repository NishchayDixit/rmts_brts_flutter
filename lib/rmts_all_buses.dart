import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_single_bus.dart';

class RmtsAllBuses extends StatefulWidget {
  const RmtsAllBuses({Key? key}) : super(key: key);

  @override
  State<RmtsAllBuses> createState() => _RmtsAllBusesState();
}

class _RmtsAllBusesState extends State<RmtsAllBuses> {
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
          color: Colors.white,
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
    var response = jsonDecode(await BaseClient()
        .get('Rmts/GetAllRmtsRoutes')
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
