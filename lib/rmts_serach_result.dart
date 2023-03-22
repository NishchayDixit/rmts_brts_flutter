import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';

class RmtsSearchResult extends StatefulWidget {
  final fromID;
  final toID;

  const RmtsSearchResult({Key? key, required this.fromID, required this.toID})
      : super(key: key);

  @override
  State<RmtsSearchResult> createState() => _RmtsSearchResultState();
}

class _RmtsSearchResultState extends State<RmtsSearchResult> {
  List<RmtsResultModel> rmtsSearchResultModel = [];
  var _loading = true;

  @override
  void initState() {
    () async {
      var obj = {
        "frompickpoint": widget.fromID.toString(),
        "topickpoint": widget.toID.toString(),
      };
      var response = jsonDecode(await BaseClient()
          .post('Rmts/GetRmtsRouteFromTo', obj)
          .catchError((err) => {print(err.toString())}));

      if (response['IsResult'] == 1) {
        List<dynamic> temp = List.from(response['ResultList']);

        for (var t in temp) {
          rmtsSearchResultModel.add(RmtsResultModel.fromJSON(t));
        }
        setState(() {
          _loading = false;
        });
        // print(response['ResultList']);
        print(rmtsSearchResultModel.toString());
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
            body: !_loading
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return SingleBus(
                          rmtsSearchResultModel[index].BusNo,
                          rmtsSearchResultModel[index].RouteNameEnglish,
                          rmtsSearchResultModel[index].RouteID);
                    },
                    itemCount: rmtsSearchResultModel.length,
                  )
                : CustomLoader(),
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
            SizedBox(
              width: 10,
            ),
            Text(
              busno.toString(),
              style: TextStyle(
                color: Colors.orange,
                fontSize: 22,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 230,
              child: Text(name.toString(),
                  style: TextStyle(
                    fontSize: 14,
                  )),
            ),
            Spacer(),
            Icon(Icons.navigate_next_rounded),
          ],
        ),
      ),
    );
  }
}
