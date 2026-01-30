import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_detection/core/theme/const_themes.dart';

class UploadedImageCard extends StatelessWidget {
  final File image;
  final VoidCallback onStartDetection;

  const UploadedImageCard({
    super.key,
    required this.image,
    required this.onStartDetection,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 160,
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
              backgroundColor: AppTheme.kPrimaryColor,
            ),
            onPressed: onStartDetection,
            child: Text(
              "Start Detection",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
