/*import 'dart:io';

import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  final List<File> images;

  const UploadScreen({super.key,required this.images});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: images.isEmpty
              ? Center(child: Text('No Pictures Yet'))
              : GridView.builder(
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
      ),
    );
  }
}
*/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plant_detection/const_themes.dart';

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
            child: Padding(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: Container(
                width: double.infinity,
                height: 1,
                decoration: BoxDecoration(
                  color: AppTheme.kPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.kPrimaryColor.withOpacity(1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: AppTheme.kPrimaryColor.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, -6),
                    ),
                    BoxShadow(
                      color: AppTheme.kPrimaryColor.withOpacity(0.5),
                      spreadRadius: 7,
                      blurRadius: 15,
                      offset: const Offset(6, 0),
                    ),
                    BoxShadow(
                      color: AppTheme.kPrimaryColor.withOpacity(0.5),
                      spreadRadius: 7,
                      blurRadius: 15,
                      offset: const Offset(-6, 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
