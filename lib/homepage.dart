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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 217, 217, 217),
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 185, 185, 185),
                              width: 1.0),
                        ),
                        hintText: "Enter Bus no.",
                      ),
                      keyboardType: TextInputType.number,
                      controller: textEditingController,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                      ),
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
                      child: const Text("Search"),
                    ),
                  ],
                ),
              ) // This trailing comma makes auto-formatting nicer for build methods.
              ),
        ),
      ),
    );
  }
}
