import 'package:flutter/material.dart';

import '../themes/color.dart';

class TemplateScreen extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  const TemplateScreen({
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.primaryColor,
      body: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // clipBehavior: Clip.antiAlias,
                // decoration: BoxDecoration(
                //   color: Colors.transparent,
                // ),
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: FittedBox(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(80)),
                  color: AppColors.darkGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
