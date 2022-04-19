import 'package:flutter/material.dart';

import '../themes/color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final Color primaryColor;
  final Color secondaryColor;
  final Function() onPressed;

  const CustomButton({
    required this.text,
    required this.isPrimary,
    required this.onPressed,
    required this.primaryColor,
    this.secondaryColor = AppColors.darkGreen,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isPrimary ? primaryColor : secondaryColor,
          fontSize: 24,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: isPrimary ? secondaryColor : primaryColor,
        padding: EdgeInsets.fromLTRB(27, 17, 27, 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        side: BorderSide(
          width: 4.5,
          color: secondaryColor,
        ),
      ),
    );
  }
}
