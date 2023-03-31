import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rmts_brts/rmts_brts_tab_screen.dart';
import 'package:sizer/sizer.dart';

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
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RMTS BRTS',
          theme: ThemeData(
            primarySwatch: Colors.grey,
          ),
          home: const RMTS_BRTSTabScreen(),
        );
      },
    );
  }
}
