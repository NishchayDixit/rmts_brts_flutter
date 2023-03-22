import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/bus_details.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';

class RmtsAllRoutes extends StatefulWidget {
  const RmtsAllRoutes({Key? key}) : super(key: key);

  @override
  State<RmtsAllRoutes> createState() => _RmtsAllRoutesState();
}

class _RmtsAllRoutesState extends State<RmtsAllRoutes> {
  List<RmtsResultModel> rmtsResultModel = [];
  var _loading = true;

  @override
  void initState() {
    () async {
      var response = jsonDecode(await BaseClient()
          .get('Rmts/GetAllRmtsRoutes')
          .catchError((err) => {print(err.toString())}));

      if (response['IsResult'] == 1) {
        List<dynamic> temp = List.from(response['ResultList']);

        for (var t in temp) {
          rmtsResultModel.add(RmtsResultModel.fromJSON(t));
        }

        setState(() {
          _loading = false;
        });
        // print(response['ResultList']);
        // print(rmtsResultModel.toString());
      } else {
        print(response['Message']);
      }
    }();
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
              child: !_loading
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      addAutomaticKeepAlives: true,
                      itemBuilder: (context, index) {
                        return SingleBus(rmtsResultModel[index]);
                      },
                      itemCount: rmtsResultModel.length,
                    )
                  : CustomLoader(),
            ),
          ),
        ),
      ),
    );
  }

  Widget SingleBus(RmtsResultModel rmtsResultModel) {
    return Container(
      height: 65,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 217, 217, 217),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BusDetails(rmtsResultModel: rmtsResultModel),
              ));
        },
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
                width: 30,
                child: Text(
                  rmtsResultModel.BusNo.toString() == "null"
                      ? ""
                      : rmtsResultModel.BusNo.toString(),
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 70,
              child: Container(
                margin: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                child: Text(rmtsResultModel.RouteNameEnglish.toString(),
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                    )),
              ),
            ),
            Expanded(
              flex: 20,
              child: Container(
                alignment: Alignment.centerRight,
                width: 30.0,
                child: Icon(Icons.navigate_next_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
