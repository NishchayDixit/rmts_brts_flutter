// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:rmts_brts/brts_home_screen.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:rmts_brts/custom_widgets/custom_text.dart';
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.only(top: 1.5.h),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.5.w),
                child: Container(
                  // height: 50,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: ColorConstants.seconderyColor,
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(0.8.h),
                        child: TabBar(
                          // indicatorColor: Colors.white,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(20.h),
                          ),
                          controller: tabController,
                          tabs: [
                            Tab(
                              child: CustomText(
                                text: 'RMTS',
                                fontFamily: 'Poppins',
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.primaryAccentTextColor,
                              ),
                            ),
                            Tab(
                              child: CustomText(
                                text: 'BRTS',
                                fontFamily: 'Poppins',
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.primaryAccentTextColor,
                              ),
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
    );
  }
}
