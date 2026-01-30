import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/Helper/auth_service.dart';
import 'features/home/presentation/views/bottom_navigation_bar_screen.dart';
import 'features/authentication/presentation/views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final isLoggedIn =
      await AuthService.isLoggedIn() &&
      await AuthService.isFirebaseUserLoggedIn();

  runApp(MyApp(initialRoute: isLoggedIn ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const BottomNavigationBarScreen(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: LoginScreen(),
        );
      },
    );
  }
}
