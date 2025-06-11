import 'package:flutter/material.dart';
import 'package:plant_detection/Screens/login_screen.dart';
//import 'package:shared_preferences/shared_preferences.dart'; // For clearing user data

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  /*Future<void> _logout(BuildContext context) async {
    // 1. Clear user session data (e.g., authentication tokens)
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all data stored by your app

    // 2. Navigate back to the login screen (or welcome screen)
    // This assumes you have a named route for your login screen like '/login'
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login', // Replace with your actual login route
          (Route<dynamic> route) => false, // This removes all previous routes
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false, // Prevents a back button
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Are you sure you want to log out?',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                //onPressed: () => _logout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // A distinct color for logout
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Go back to the previous screen
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}