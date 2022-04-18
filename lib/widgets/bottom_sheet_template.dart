import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';

class BottomSheetTemplate extends StatelessWidget {
  final Color background;
  final String title;
  final Widget child;

  const BottomSheetTemplate({
    Key? key,
    required this.background,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 35,
      ),
      height: MediaQuery.of(context).size.height - 150,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 77,
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 52,
              bottom: 5,
            ),
            child: FittedBox(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.white,
                  // fontSize: 60,
                ),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: child,
          )),
        ],
      ),
    );
  }
}
