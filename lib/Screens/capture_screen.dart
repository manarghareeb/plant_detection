import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../const_themes.dart';

class CaptureScreen extends StatelessWidget {
  final Function(File) onImageCaptured;
  const CaptureScreen({super.key,required this.onImageCaptured});

  Future<void> takePicture(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage Validity is Rejected.')),
      );
      return;
    }

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      File file = File(photo.path);
      onImageCaptured(file);
    }
  }

  Future<void> openGallery(BuildContext context) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      onImageCaptured(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.kBackgroundColor,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.camera_alt, color: AppTheme.kSecondaryColor,size: 30,),
                    label: Text(
                      'Take Picture',
                      style: TextStyle(fontSize: 20,color: AppTheme.kSecondaryColor),
                    ),
                    onPressed: () => takePicture(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      //textStyle: const TextStyle(fontSize: 18),
                      minimumSize: const Size(250, 60),
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton.icon(
                    icon: Icon(Icons.photo_library, size: 30, color: AppTheme.kSecondaryColor,),
                    label: Text('Open Gallery',
                        style: TextStyle(fontSize: 20,color: AppTheme.kSecondaryColor)),
                    onPressed: () => openGallery(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      minimumSize: const Size(250, 60),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
