import 'dart:io';

import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  final List<File> images;

  const UploadScreen({super.key,required this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
