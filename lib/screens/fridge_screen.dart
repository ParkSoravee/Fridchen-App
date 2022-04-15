import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:provider/provider.dart';

class FridgeScreen extends StatefulWidget {
  const FridgeScreen({Key? key}) : super(key: key);

  @override
  State<FridgeScreen> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
      title: 'FRIDGE',
      primaryColor: AppColors.lightGreen,
      secondaryColor: AppColors.green,
      child: Column(
        children: [],
      ),
    );
  }
}
