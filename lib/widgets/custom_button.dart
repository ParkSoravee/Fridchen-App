import 'package:flutter/material.dart';

import '../themes/color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final bool isBorder;
  final Color primaryColor;
  final Color secondaryColor;
  final Function() onPressed;
  final double downsize;

  const CustomButton({
    required this.text,
    required this.isPrimary,
    this.isBorder = false,
    required this.onPressed,
    required this.primaryColor,
    this.secondaryColor = AppColors.darkGreen,
    this.downsize = 0,
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
        padding: EdgeInsets.fromLTRB(
          27 - downsize,
          17 - downsize,
          27 - downsize,
          14 - downsize,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        side: BorderSide(
          width: 4.5,
          color: isBorder ? primaryColor : secondaryColor,
        ),
      ),
    );
  }
}
