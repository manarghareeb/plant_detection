import 'package:flutter/material.dart';
import 'package:plant_detection/Screens/bottom_navigation_bar_screen.dart';
import 'package:plant_detection/Screens/home_screen.dart';
import 'package:plant_detection/Screens/register_screen.dart';
import 'package:plant_detection/const_themes.dart';

import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
            ),
            SizedBox(height: 55,),
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Circular border
                  borderSide: BorderSide(color: Colors.transparent), // No border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                filled: true,
                fillColor: Color(0xFFD9D9D9), // Background color
                hintText: 'Username,Email & Phone number',
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Circular border
                    borderSide: BorderSide(color: Colors.transparent), // No border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: Color(0xFFD9D9D9),
                hintText: 'Password',
                suffixIcon: Icon(Icons.remove_red_eye_outlined)
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                  );
                }, child:Text('Forget Password?',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                ),
              ],
            ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.kPrimaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                      ),
                    ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Sign Up',style: TextStyle(color: AppTheme.kPrimaryColor,fontWeight: FontWeight.bold),)
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
