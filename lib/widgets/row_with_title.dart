import 'package:flutter/material.dart';

import '../themes/color.dart';

class RowWithTitle extends StatelessWidget {
  final String title;
  final Widget child;

  const RowWithTitle({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.darkGreen,
            fontSize: 36,
          ),
        ),
        child,
        // Expanded(
        //   child: child,
        // ),
      ],
    );
  }
}
