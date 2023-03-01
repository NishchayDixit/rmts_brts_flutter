// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class RMTS_HomeScreen extends StatefulWidget {
  const RMTS_HomeScreen({Key? key}) : super(key: key);

  @override
  State<RMTS_HomeScreen> createState() => _RMTS_HomeScreenState();
}

class _RMTS_HomeScreenState extends State<RMTS_HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 83,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/container_bg.png'),
                        fit: BoxFit.fill),
                  ),
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    body: Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 26),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: const <Widget>[
                                Text(
                                  'RMTS',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Rajkot Mass Transport Service',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'SEARCH ROUTES',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                                Stack(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 17,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
