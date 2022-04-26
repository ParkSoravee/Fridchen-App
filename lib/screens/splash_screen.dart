import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGreen,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.yellow,
        ),
      ),
    );
  }
}
