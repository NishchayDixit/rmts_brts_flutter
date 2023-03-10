// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:rmts_brts/brts_home_screen.dart';
import 'package:rmts_brts/rmts_home_screen.dart';

class RMTS_BRTSTabScreen extends StatefulWidget {
  const RMTS_BRTSTabScreen({Key? key}) : super(key: key);

  @override
  State<RMTS_BRTSTabScreen> createState() => _RMTS_BRTSTabScreenState();
}

class _RMTS_BRTSTabScreenState extends State<RMTS_BRTSTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      // height: 50,
                      width: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 230, 230, 230),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: TabBar(
                              indicatorColor: Colors.white,
                              indicatorWeight: 2,
                              indicatorPadding: EdgeInsets.all(1.0),
                              indicator: BoxDecoration(
                                color: Color.fromARGB(255, 185, 185, 185),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              controller: tabController,
                              tabs: const [
                                Tab(
                                  text: 'RMTS',
                                ),
                                Tab(
                                  text: 'BRTS',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          RMTSHomeScreen(),
                          BRTSHomeScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
