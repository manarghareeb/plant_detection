import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plant_detection/core/theme/const_themes.dart';
import 'package:plant_detection/core/widgets/bottom_nav_shadow.dart';

class UploadScreen extends StatelessWidget {
  final List<File> images;

  const UploadScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: images.isEmpty
                ? const Center(child: Text('No Pictures Yet'))
                : GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Image.file(
                  images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: const BottomNavShadow(),
          ),
        ],
      ),
    );
  }
}
