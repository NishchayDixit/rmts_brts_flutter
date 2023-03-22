import 'package:flutter/material.dart';
import 'package:rmts_brts/Model/rmts_result_model.dart';
import 'package:rmts_brts/bus_details.dart';

class CustomSingleBus extends StatefulWidget {
  final RmtsResultModel rmtsResultModel;

  const CustomSingleBus({Key? key, required this.rmtsResultModel})
      : super(key: key);

  @override
  State<CustomSingleBus> createState() => _CustomSingleBusState();
}

class _CustomSingleBusState extends State<CustomSingleBus> {
  @override
  Widget build(BuildContext context) {
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
                    BusDetails(rmtsResultModel: widget.rmtsResultModel),
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
                  widget.rmtsResultModel.BusNo.toString() == "null"
                      ? ""
                      : widget.rmtsResultModel.BusNo.toString(),
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
                child: Text(widget.rmtsResultModel.RouteNameEnglish.toString(),
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
