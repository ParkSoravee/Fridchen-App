import 'package:flutter/material.dart';

import '../themes/color.dart';

class TemplateScreen extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;
  final Widget child;
  final Function? addNew;

  const TemplateScreen({
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
    required this.child,
    this.addNew,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 18,
              top: 47,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 100,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 136,
                  // height: MediaQuery.of(context).size.height / 6.2,
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
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(80)),
                      color: AppColors.darkGreen,
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: addNew != null
          ? FloatingActionButton(
              onPressed: () {
                addNew!();
              },
              child: Icon(
                Icons.add,
                size: 38,
                color: AppColors.darkGreen,
              ),
              backgroundColor: primaryColor,
            )
          : null, //TODO: modal bottom template (very high)
    );
  }
}
