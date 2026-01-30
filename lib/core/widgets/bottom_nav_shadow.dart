import 'package:flutter/material.dart';
import 'package:plant_detection/core/theme/const_themes.dart';

class BottomNavShadow extends StatelessWidget {
  const BottomNavShadow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

