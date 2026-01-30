import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_detection/core/widgets/bottom_nav_shadow.dart';
import 'package:plant_detection/features/home/presentation/widgets/category_list_view.dart';
import 'package:plant_detection/features/home/presentation/widgets/floating_action_button_widget.dart';
import 'package:plant_detection/features/home/presentation/widgets/home_app_bar.dart';
import 'package:plant_detection/features/home/presentation/widgets/start_detection_placeholder.dart';
import 'package:plant_detection/features/home/presentation/widgets/uploaded_image_card.dart';
import 'package:plant_detection/features/plant_detection/presentation/views/detection_results_screen.dart';
import 'package:plant_detection/core/theme/const_themes.dart';
import '../../../authentication/presentation/views/edit_profile_screen.dart';
import '../../../authentication/presentation/views/logout_screen.dart';

class HomeScreen extends StatefulWidget {
  final File? capturedImage;
  const HomeScreen({super.key, this.capturedImage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "User";
  // String? userPhotoUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (doc.exists) {
          setState(() {
            userName = doc.data()?['name'] ?? "User";
            // userPhotoUrl = doc.data()?['photoUrl'];
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user data: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      appBar: HomeAppBar(
        name: _isLoading ? "Loading..." : "Welcome,\n$userName",
        onSelected: (value) {
          if (value == "Edit Profile") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()),
            ).then((_) => _fetchUserData());
          } else if (value == "Logout") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogoutScreen()),
            );
          }
        },
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Color(0xFF29CCA3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:
                          widget.capturedImage != null
                              ? UploadedImageCard(
                                image: widget.capturedImage!,
                                onStartDetection: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => DetectionResultsScreen(
                                            capturedImage:
                                                widget.capturedImage!,
                                          ),
                                    ),
                                  );
                                },
                              )
                              : const StartDetectionPlaceholder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Categories
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Scrollable Categories
                  const CategoryListView(),
                  Spacer(),
                  SizedBox(height: 10),
                  const BottomNavShadow(),
                ],
              ),
      floatingActionButton: FloatingActionButtonWidget(onPressed: () {}),
    );
  }
}
