import 'package:flutter/material.dart';
import 'package:plant_detection/Screens/home_screen.dart';

import 'Screens/bottom_navigation_bar_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/plant_diagnosis_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //home: BottomNavigationBarScreen(),
      //home: LoginScreen(),
      home: PlantDiagnosisScreen(),
    );
  }
}


