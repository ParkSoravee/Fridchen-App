import 'package:flutter/material.dart';

import '../themes/color.dart';

class MyDateUtils {
  static Future<DateTime?> setExpDate({
    required BuildContext context,
    required String title,
    required DateTime initDate,
  }) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 2000),
      ),
      helpText: title,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.green, // header background color
            onPrimary: AppColors.white, // header text color
            onSurface: AppColors.darkGreen, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: AppColors.green, // button text color
            ),
          ),
        ),
        child: child!,
      ),
    );

    return date;
  }
}
