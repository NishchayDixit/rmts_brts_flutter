import 'package:flutter/material.dart';
import 'package:rmts_brts/brts_home_screen.dart';
import 'package:rmts_brts/rmts_home_screen.dart';

void main() {
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
      ),
      home: const BRTSHomeScreen(),
    );
  }
}
