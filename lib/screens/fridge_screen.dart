import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import '../providers/tags.dart';

class FridgeScreen extends StatefulWidget {
  const FridgeScreen({Key? key}) : super(key: key);

  @override
  State<FridgeScreen> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  @override
  Widget build(BuildContext context) {
    final defaultTags = Provider.of<Tags>(context, listen: false).defaultTags;
    return TemplateScreen(
      title: 'FRIDGE',
      primaryColor: AppColors.lightGreen,
      secondaryColor: AppColors.green,
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Column(
          children: [
            SearchBar(
              tags: defaultTags,
              color: AppColors.green,
              bgColor: AppColors.lightGreen,
            ),
          ],
        ),
      ),
    );
  }
}
