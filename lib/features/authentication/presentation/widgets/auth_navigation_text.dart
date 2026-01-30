import 'package:flutter/material.dart';
import 'package:plant_detection/core/theme/const_themes.dart';

class AuthNavigatorText extends StatelessWidget {
  const AuthNavigatorText({
    super.key,
    required bool isLoading,
    required this.text,
    required this.textButton,
    required this.onTap,
  }) : _isLoading = isLoading;

  final bool _isLoading;
  final String text;
  final String textButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed:
              _isLoading
                  ? null
                  : onTap,
          child: Text(
            textButton,
            style: TextStyle(
              color: AppTheme.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
