import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';

import '../providers/tags.dart';

class TagItem extends StatefulWidget {
  final Tag tag;
  final Function selectTag; // TODO !!

  TagItem(this.tag, this.selectTag);

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  bool isHighlight = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isHighlight = !isHighlight;
          widget.selectTag(widget.tag.id);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color:
              isHighlight ? Color(widget.tag.colorCode) : AppColors.darkGreen,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: Chip(
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 4,
            ),
            labelStyle: TextStyle(
              fontSize: 20,
              height: 0.5,
              color: isHighlight
                  ? AppColors.darkGreen
                  : Color(widget.tag.colorCode),
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color(widget.tag.colorCode),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            label: Text(
              widget.tag.name,
              // overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: Colors.transparent,
            // backgroundColor:
            //     isHighlight ? Color(widget.tag.colorCode) : AppColors.darkGreen,
          ),
        ),
      ),
    );
  }
}
