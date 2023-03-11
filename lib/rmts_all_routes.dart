import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_search_result_model.dart';

class RmtsAllRoutes extends StatefulWidget {
  const RmtsAllRoutes({Key? key}) : super(key: key);

  @override
  State<RmtsAllRoutes> createState() => _RmtsAllRoutesState();
}

class _RmtsAllRoutesState extends State<RmtsAllRoutes> {
  List<RmtsSearchResultModel> rmtsResultModel = [];
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
          rmtsResultModel.add(RmtsSearchResultModel.fromJSON(t));
        }

        setState(() {
          _loading = false;
        });
        // print(response['ResultList']);
        print(rmtsResultModel.toString());
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
                        return SingleBus(
                            rmtsResultModel[index].BusNo,
                            rmtsResultModel[index].RouteNameEnglish,
                            rmtsResultModel[index].RouteID);
                      },
                      itemCount: rmtsResultModel.length,
                    )
                  : Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      color: Color.fromARGB(100, 195, 195, 195),
                      child: Container(
                        height: 90,
                        width: 300,
                        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 15,
                              child: CircularProgressIndicator(),
                            ),
                            Expanded(
                              flex: 85,
                              child: Text(
                                "Please Wait...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget SingleBus(var busno, var name, var routeid) {
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
        onPressed: () {},
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
                width: 30,
                child: Text(
                  busno.toString() == "null" ? "" : busno.toString(),
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
                child: Text(name.toString(),
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
