import 'package:flutter/material.dart';
import 'package:rmts_brts/detail_bus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Enter Bus no.",
            ),
            keyboardType: TextInputType.number,
            controller: textEditingController,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailBus(
                    bus_no: textEditingController.text.toString(),
                  ),
                ),
              );
            },
            child: Text("Submit"),
          ),
        ],
      ) // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
