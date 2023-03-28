import 'package:flutter/material.dart';
import 'package:rmts_brts/Model/brts_route_details.dart';

class CustomExpansionTile extends StatefulWidget {
  final String brtsPickUpPointName;
  final BrtsRouteDetails brtsRouteDetails;
  const CustomExpansionTile({Key? key, required this.brtsRouteDetails, required this.brtsPickUpPointName}) : super(key: key);
  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.brtsPickUpPointName),
      children: [
        Table(
          children: [
            TableRow(
              children: [
                Text("Fare"),
                Text(":"),
                Text("₹ ${widget.brtsRouteDetails.BrtsFare}/-"),
              ]
            ),
            TableRow(
              children: [
                Text("Distance"),
                Text(":"),
                Text("${widget.brtsRouteDetails.BrtsDistance} km."),
              ],
            ),
            TableRow(
              children: [
                Text("Duration"),
                Text(":"),
                Text("${widget.brtsRouteDetails.BrtsFare} minutes"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
