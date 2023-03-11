import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rmts_brts/brts_home_screen.dart';
import 'package:rmts_brts/rmts_all_routes.dart';
import 'package:rmts_brts/rmts_brts_tab_screen.dart';
import 'package:rmts_brts/rmts_live_bus.dart';
import 'package:rmts_brts/rmts_serach_result.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RMTS BRTS',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        // useMaterial3: true
      ),
      home: const RMTS_BRTSTabScreen(),
    );
  }
}
