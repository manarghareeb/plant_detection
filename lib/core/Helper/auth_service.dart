import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = 'isLoggedIn';

  // Check login state
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Save login state
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  // Check Firebase auth state
  static Future<bool> isFirebaseUserLoggedIn() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  // Clear login state
  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await setLoggedIn(false);
  }
}