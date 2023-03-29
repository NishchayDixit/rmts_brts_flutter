import 'package:flutter/material.dart';
import 'package:rmts_brts/Model/brts_pickup_points.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';

class CustomDropDown extends StatefulWidget {
  final String text;
  final FocusNode? focusNode;
  final List<BrtsPickupPoints> brtsPickupPoints;
  dynamic currentSelection;
  CustomDropDown(
      {Key? key,
      required this.text,
      this.focusNode,
      required this.brtsPickupPoints,required this.currentSelection})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomText(
            text: widget.text,
            fontFamily: 'Poppins',
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 8,
          child: SizedBox(
            height: 39,
            child: Container(
              child: DropdownButtonFormField(
                // decoration: InputDecoration(
                //   // hintText: "Name",
                //   labelStyle: TextStyle(color: Colors.black),
                //   filled: true,
                //   fillColor: const Color.fromARGB(255, 242, 242, 242),
                //   border: OutlineInputBorder(
                //     borderSide: BorderSide.none,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),

                focusNode: widget.focusNode,
                items: widget.brtsPickupPoints
                    .map((e) => DropdownMenuItem(
                          value: int.parse(e.BrtsPickupPointID.toString()),
                          child: Text(e.BrtsPickUpPointName),
                        ))
                    .toList(),

                value: widget.currentSelection["val"],
                onChanged: (value) {
                  print(value!);
                  setState(() => widget.currentSelection["val"] = int.parse(value.toString()));
                },
                // value: "a",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
