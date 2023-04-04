import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        // width: double.infinity,
        // height: double.infinity,
        color: Color.fromARGB(100, 195, 195, 195),
        child: Container(
            height: 90,
            width: 300,
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(flex: 15, child: CircularProgressIndicator()),
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
            )));
  }
}
