import 'package:flutter/material.dart';
import 'package:plant_detection/core/theme/const_themes.dart';

class CustomButtomWidget extends StatelessWidget {
  const CustomButtomWidget({
    super.key,
    required this.text,
    this.onTap,
    required this.isLoading,
    //this.width,
  });
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  //final double? width;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 600 ? 500 : width * 0.9;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 50,
        width: maxWidth,
        decoration: BoxDecoration(
          color:
              isLoading
                  ? AppTheme.kPrimaryColor.withOpacity(0.5)
                  : AppTheme.kPrimaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child:
              isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
        ),
      ),
    );
  }
}
