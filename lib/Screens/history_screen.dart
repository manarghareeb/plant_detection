import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_detection/const_themes.dart';

import '../Models/model.dart';

class HistoryScreen extends StatefulWidget {
  //final List<File> capturedImages;

  const HistoryScreen({
    super.key,
    //required this.capturedImages,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool showHistory = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.kBackgroundColor,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "This Month",
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                      IconButton(
                        onPressed: () => setState(() => showHistory = !showHistory),
                        icon: Icon(showHistory ? Icons.expand_less : Icons.expand_more),
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                  if (showHistory)
                    HistoryManager.historyItems.isEmpty
                    //widget.capturedImages.isEmpty
                        ? const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "No history available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                        : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        //itemCount: widget.capturedImages.length,
                        itemCount: HistoryManager.historyItems.length,
                        itemBuilder: (context, index) {
                          //final image = widget.capturedImages[index];
                          final item = HistoryManager.historyItems[index];
                          return ListTile(
                            tileColor: Colors.white,
                            leading: Image.file(
                              //image,
                              item.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              //"Plant Diagnosis",
                              item.diseaseName,
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            subtitle: Text(
                              DateFormat('dd MMM yyyy   hh:mm a').format(item.date),
                              //DateFormat('dd MMM yyyy   hh:mm a').format(DateTime.now()),
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          );
                        },
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
                        offset: Offset(0, 6),
                      ),
                      BoxShadow(
                        color: AppTheme.kPrimaryColor.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, -6),
                      ),
                      BoxShadow(
                        color: AppTheme.kPrimaryColor.withOpacity(0.5),
                        spreadRadius: 7,
                        blurRadius: 15,
                        offset: Offset(6, 0),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}

