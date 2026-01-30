import 'package:flutter/material.dart';
import 'package:plant_detection/core/theme/const_themes.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final String imagePath;
  const CategoryItem({super.key, required this.label, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: AppTheme.kPrimaryColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: Image.asset(imagePath),
          ),
          SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 12, color: AppTheme.kSecondaryColor)),
        ],
      ),
    );
  }
}