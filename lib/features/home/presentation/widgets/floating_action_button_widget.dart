import 'package:flutter/material.dart';
import 'package:plant_detection/core/theme/const_themes.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key, required this.onPressed,
  });
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 90,
          height: 20,
          decoration: BoxDecoration(
            color: AppTheme.kThirdColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppTheme.kPrimaryColor, width: 1),
          ),
          child: Center(
            child: Text(
              "chat with AI",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        SizedBox(height: 5),
        FloatingActionButton(
          mini: true,
          shape: CircleBorder(),
          backgroundColor: AppTheme.kPrimaryColor,
          onPressed: onPressed,
          child: Image.asset('assets/robot.png'),
        ),
      ],
    );
  }
}
