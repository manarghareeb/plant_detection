import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم التقاط الصورة')),
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: Icon(Icons.camera_alt),
        label: Text('Photography and Saving in the Gallery'),
        onPressed: () => takePicture(context),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: TextStyle(fontSize: 18),
        ),
      ),
    );

  }
}
