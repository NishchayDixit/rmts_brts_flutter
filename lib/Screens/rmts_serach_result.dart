import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rmts_brts/Api/base_client.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/custom_widgets/custom_loader.dart';
import 'package:rmts_brts/custom_widgets/custom_single_bus.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: Colors.white,
            width: double.infinity,
            child: FutureBuilder(
              future: getSearchResult(formID: widget.fromID, toID: widget.toID),
              builder: (context, snapshot) {
                if (snapshot != null && snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CustomSingleBus(
                          rmtsResultModel: rmtsSearchResultModel[index]);
                    },
                    itemCount: rmtsSearchResultModel.length,
                  );
                } else if (_loading) {
                  return CustomLoader();
                }
                return Center(
                  child: CustomText(
                    text: "No Result Found",
                    fontFamily: "Poppins",
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w300,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<List<RmtsResultModel>?> getSearchResult(
      {required formID, required toID}) async {
    _loading = true;
    var obj = {
      "frompickpoint": widget.fromID.toString(),
      "topickpoint": widget.toID.toString(),
    };
    var response = jsonDecode(await BaseClient()
        .post('Rmts/GetRmtsRouteFromTo', obj)
        .catchError((err) => {print(err.toString())}));
    if (response == null) {
      print(response['Message']);
      return [];
    }
    if (response['IsResult'] == 1) {
      List<dynamic> temp = List.from(response['ResultList']);

      for (var t in temp) {
        rmtsSearchResultModel.add(RmtsResultModel.fromJSON(t));
      }
      _loading = false;
      return rmtsSearchResultModel;
      // print(response['ResultList']);
      // print(rmtsSearchResultModel.toString());
    }
    print(response['Message']);
    _loading = false;
    return null;
  }
}
