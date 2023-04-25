import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:rmts_brts/Screens/about_us.dart';
import 'package:rmts_brts/Screens/rmts_brts_tab_screen.dart';
import 'package:rmts_brts/Screens/rmts_live_bus.dart';
import 'package:rmts_brts/config/color_constants.dart';
import 'package:sizer/sizer.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  final _baseStyle = TextStyle(
    fontFamily: 'Poppins',
    color: ColorConstants.primaryAccentTextColor,
    fontSize: 12.0.sp,
    fontWeight: FontWeight.w500,
  );

  final _selectedStyle = TextStyle(
    fontFamily: 'Poppins',
    color: ColorConstants.primaryAccentTextColor,
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
  );

  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "RMTS-BRTS",
          baseStyle: _baseStyle,
          selectedStyle: _selectedStyle,
          colorLineSelected: ColorConstants.primaryColor,
        ),
        const RMTS_BRTSTabScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Live Bus Tracking",
          baseStyle: _baseStyle,
          selectedStyle: _selectedStyle,
          colorLineSelected: ColorConstants.primaryColor,
        ),
        const RmtsLiveBus(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "About Us",
          baseStyle: _baseStyle,
          selectedStyle: _selectedStyle,
          colorLineSelected: ColorConstants.primaryColor,
        ),
        const AboutUs(),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: ColorConstants.seconderyColor,
      initPositionSelected: 0,
      contentCornerRadius: 2.0.h,
      slidePercent: 58.0,
    );
  }
}
