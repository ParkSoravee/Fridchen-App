import 'package:flutter/material.dart';
import 'package:fridchen_app/widgets/tag_item.dart';

import '../providers/tags.dart';

class TagSelect extends StatefulWidget {
  final List<Tag> tags;
  final List<Tag> selectedTags = [];
  final Function setSelectedTags;

  TagSelect({
    required this.tags,
    required this.setSelectedTags,
  });

  @override
  State<TagSelect> createState() => _TagSelectState();
}

class _TagSelectState extends State<TagSelect> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        // color: Color(0x0A000000),
        height: 80,
        // child: TagList(
        //   tags: widget.tags,
        //   selectTag: widget.setSelectedTags,
        // ),
        child: SingleChildScrollView(
          child: Wrap(
            children: widget.tags.map<Container>((Tag tag) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                height: 25,
                child: TagItem(
                  tag: tag,
                  selectTag: widget.setSelectedTags,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
