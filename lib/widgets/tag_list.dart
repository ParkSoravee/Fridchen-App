import 'package:flutter/material.dart';
import 'package:fridchen_app/widgets/tag_item.dart';

import '../providers/tags.dart';

class TagList extends StatelessWidget {
  final List<Tag> tags;
  final Function? selectTag;

  const TagList({
    required this.tags,
    this.selectTag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: double.infinity,
      child: ListView.builder(
        clipBehavior: Clip.antiAlias,
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (ctx, i) {
          return TagItem(
            tag: tags[i],
            selectTag: selectTag,
            isSelected: false,
          );
        },
      ),
    );
  }
}
