import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';

class AppSnackBar {
  const AppSnackBar();

  void build({
    required BuildContext context,
    required String text,
    Color color = AppColors.lightGreen,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isError
              ? 'Error something went wrong...'
              : 'Add list item successfully!',
          style: TextStyle(
            color: AppColors.darkGreen,
            fontFamily: 'BebasNeue',
            fontSize: 20,
          ),
        ),
        duration: Duration(milliseconds: 2000),
        width: MediaQuery.of(context).size.width - 20,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        backgroundColor: isError ? AppColors.red : color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
