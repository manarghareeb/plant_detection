import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_detection/Screens/home_screen.dart';
import 'package:plant_detection/Screens/upload_screen.dart';
import '../const_themes.dart';
import 'capture_screen.dart';
import 'history_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int currentIndex = 0;

  List<File> images = [];
  List<Widget> screens = [];
  void addImage(File image) {
    setState(() {
      images.add(image);
      currentIndex = 0;
    });
  }
  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(capturedImage: images.isNotEmpty ? images.last : null),  // new
      UploadScreen(images: images),
      CaptureScreen(onImageCaptured: addImage),
      //HistoryScreen(diagnoses: [],),   // with model
      //HistoryScreen(capturedImages: images,),
      HistoryScreen(),
    ];
    return Scaffold(
      body: screens[currentIndex],
      // Bottom Navigation Bar
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 25,
          selectedItemColor: AppTheme.kPrimaryColor,
          unselectedItemColor: Colors.black,
          currentIndex: currentIndex,
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: "Upload",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: "Capture",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
          ],
        ),
      ),
    );
  }
}

