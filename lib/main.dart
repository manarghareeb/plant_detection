import 'package:flutter/material.dart';
import 'package:plant_detection/Screens/home_screen.dart';

import 'Helper/auth_service.dart';
import 'Screens/bottom_navigation_bar_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/plant_diagnosis_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final isLoggedIn = await AuthService.isLoggedIn() &&
      await AuthService.isFirebaseUserLoggedIn();

  runApp(MyApp(initialRoute: isLoggedIn ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const BottomNavigationBarScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //home: BottomNavigationBarScreen(),
      home: LoginScreen(),
      //home: PlantDiagnosisScreen(),
    );
  }
}


