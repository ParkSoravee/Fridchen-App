import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';

class AppSnackBar extends StatelessWidget {
  final String text;
  final bool isError;
  final Color color;
  final Color textColor;

  const AppSnackBar({
    required this.text,
    this.isError = false,
    this.color = AppColors.lightGreen,
    this.textColor = AppColors.darkGreen,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      ),
      duration: Duration(milliseconds: 1500),
      width: MediaQuery.of(context).size.width - 10,
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
