import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_detection/Screens/detection_results_screen.dart';
import 'package:plant_detection/const_themes.dart';

import 'edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final File? capturedImage;
  const HomeScreen({Key? key, this.capturedImage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
          ),
        ),
        title: Text(
          "Welcome,\nJamelia",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.black),
            onSelected: (value) {
              if (value == "Edit Profile") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: "Home",
                child: ListTile(
                  leading: Icon(Icons.home, color: Colors.black),
                  title: Text("Home"),
                ),
              ),
              PopupMenuItem(
                  value: "Edit Profile",
                  child: ListTile(
                    leading: Icon(Icons.person_rounded, color: Colors.black),
                    title: Text("Edit Profile"),
                  )
              ),
              PopupMenuItem(
                  value: "Logout",
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.black),
                    title: Text("Logout"),
                  ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Start Detection Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color: Color(0xFF29CCA3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: widget.capturedImage != null
                  ? Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        widget.capturedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 160,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      "Your Photo is\n  Uploaded",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 5,
                            color: Colors.black87,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppTheme.kPrimaryColor
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetectionResultsScreen()),
                        );
                      },
                      child: Text(
                        "Start Detection",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Icon(Icons.cloud_upload, color: Colors.white, size: 40),
                    SizedBox(height: 15),
                    Text("Start Detection",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    Text("Choose categorie and start diagnose",
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          // Categories
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10),
          // Scrollable Categories
          Container(
            color: Colors.white,
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                CategoryItem(imagePath: 'assets/apple-black-silhouette-with-a-leaf_64px.png', label: "APPLE"),
                CategoryItem(imagePath: 'assets/tomato_32px.png', label: "TOMATO"),
                CategoryItem(imagePath: 'assets/cucumber_32px.png', label: "CUCUMBER"),
                CategoryItem(imagePath: 'assets/corn_32px.png', label: "CORN"),
                CategoryItem(imagePath: 'assets/menu_24px.png', label: "OTHER"),
              ]),
          ),
          Spacer(),
          // Chat with AI Floating Button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Align content to the right
                children: [
                  // "Chat with AI" text container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 90,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppTheme.kThirdColor,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppTheme.kPrimaryColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "chat with AI",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                    ],
                  ),
                  SizedBox(height: 5), // Spacing between text and button
                  // Row for alignment
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 10), // Add spacing if needed
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.kPrimaryColor, // Outer background color
                        ),
                        child: CircleAvatar(
                          backgroundColor: AppTheme.kPrimaryColor, // Inner background color
                          child: Image.asset('assets/robot.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              )

              /*Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 90,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppTheme.kThirdColor,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all( // Add black border
                              color: AppTheme.kPrimaryColor,
                              width: 1, // Border thickness
                            ),
                          ),
                          child: Center(
                            child: Text(
                                "chat with AI",
                                style: TextStyle(color: Colors.black)),
                          )
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.kPrimaryColor, // Outer background color
                    ),
                    child: CircleAvatar(
                      backgroundColor: AppTheme.kPrimaryColor, // Inner background color
                      child: Image.asset('assets/robot.png'),
                    ),
                  )
                ],
              ),*/
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(
                color: AppTheme.kPrimaryColor,
                boxShadow: [
                  // shadow in bottom
                  BoxShadow(
                    color: AppTheme.kPrimaryColor.withOpacity(1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                  // shadow in top
                  BoxShadow(
                    color: AppTheme.kPrimaryColor.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, -6),
                  ),
                  // shadow in right
                  BoxShadow(
                    color: AppTheme.kPrimaryColor.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 15,
                    offset: Offset(6, 0),
                  ),
                  // shadow in left
                  BoxShadow(
                    color: AppTheme.kPrimaryColor.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 15,
                    offset: Offset(-6, 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Category Item Widget
class CategoryItem extends StatelessWidget {
  final String label;
  final String imagePath;
  const CategoryItem({required this.label, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all( // Add black border
                color: AppTheme.kPrimaryColor,
                width: 1, // Border thickness
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6), // Grey shadow
                  spreadRadius: 2, // Expands shadow outward
                  blurRadius: 4, // Softens the shadow
                  offset: Offset(3, 3), // Moves shadow outward
                ),
              ],
            ),
            child: Image.asset(imagePath),
          ),
          SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 12, color: AppTheme.kSecondaryColor)),
        ],
      ),
    );
  }
}
