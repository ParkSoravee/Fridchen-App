import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';

import '../providers/tags.dart';

class TagItem extends StatelessWidget {
  final Tag tag;
  const TagItem(this.tag);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.symmetric(horizontal: 15),
    //   // height: 20,
    //   // color: Color(tag.colorCode),
    //   child: Text(
    //     tag.name,
    //     style: TextStyle(
    //       fontSize: 18,
    //       color: AppColors.darkGreen,
    //       background: Paint()
    //         ..strokeWidth = 22
    //         ..color = Color(tag.colorCode)
    //         ..style = PaintingStyle.stroke
    //         ..strokeJoin = StrokeJoin.round,
    //     ),
    //   ),
    // );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 4,
        ),
        labelStyle: TextStyle(
          fontSize: 20,
          color: AppColors.darkGreen,
        ),
        label: Text(
          tag.name,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Color(tag.colorCode),
      ),
    );
  }
}
