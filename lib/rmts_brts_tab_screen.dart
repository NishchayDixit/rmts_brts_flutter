// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:rmts_brts/brts_home_screen.dart';
import 'package:rmts_brts/rmts_home_screen.dart';
import 'package:sizer/sizer.dart';

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
          body: Container(
            margin: EdgeInsets.only(top: 1.5.h),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.h),
                  child: Container(
                    // height: 50,
                    width: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 230, 230),
                      borderRadius: BorderRadius.circular(1.2.h),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(0.8.h),
                          child: TabBar(
                            indicatorColor: Colors.white,
                            indicatorWeight: 2,
                            indicator: BoxDecoration(
                              color: const Color.fromARGB(255, 185, 185, 185),
                              borderRadius: BorderRadius.circular(0.7.h),
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
    );
  }
}
