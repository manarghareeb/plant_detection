import 'package:flutter/material.dart';

class StartDetectionPlaceholder extends StatelessWidget {
  const StartDetectionPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Icon(
            Icons.cloud_upload,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: 15),
          Text(
            "Start Detection",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            "Choose categorie and start diagnose",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
