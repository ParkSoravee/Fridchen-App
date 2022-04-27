import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';

class Tag {
  final String id;
  final String name;
  final int colorCode;

  Tag(this.id, this.name, this.colorCode);
}

class Tags with ChangeNotifier {
  List<Tag> _items = [
    Tag('6267c066c1550ec4cddf83a4', 'dairy', 0xFFFCCA46),
    Tag('6267c0abc1550ec4cddf83a6', 'Vegetable', AppColors.lightGreen.hashCode),
    Tag('6267c0c6c1550ec4cddf83a8', 'Meat', 0xFFFE7F2D),
    Tag('6267c0d6c1550ec4cddf83aa', 'Fresh', AppColors.green.hashCode),
    Tag('6267c0f4c1550ec4cddf83ac', 'seasoning', 0xFFFCCA46),
    Tag('6267c11ec1550ec4cddf83ae', 'dessert', 0xFFFE532D),
    Tag('6267c146c1550ec4cddf83b0', 'sause', 0xFFFE7F2D),
  ];

  // List<Tag> _defaultTags = [
  //   Tag('1', 'Dairy', AppColors.yellow.hashCode),
  //   Tag('2', 'Vegetable', AppColors.lightGreen.hashCode),
  //   Tag('3', 'Meat', AppColors.orange.hashCode),
  //   Tag('4', 'Fresh', AppColors.green.hashCode),
  // ];

  List<Tag> get defaultTags {
    return [..._items];
  }

  List<Tag> getTagsById(List<String> tagIds) {
    final List<Tag> selectTags = [];
    tagIds.forEach((tagId) {
      selectTags.add(_items.firstWhere((e) => e.id == tagId));
    });

    return selectTags;
  }

  Tag getTagById(String id) {
    final selectTag = _items.firstWhere((e) => e.id == id);
    return selectTag;
  }
}
