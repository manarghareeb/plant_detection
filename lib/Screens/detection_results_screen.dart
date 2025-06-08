import 'package:flutter/material.dart';

class DetectionResultsScreen extends StatefulWidget {
  const DetectionResultsScreen({super.key});

  @override
  State<DetectionResultsScreen> createState() => _DetectionResultsScreenState();
}

class _DetectionResultsScreenState extends State<DetectionResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detection Results"),
      ),
    );
  }
}
