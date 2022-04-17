import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';

class Tag {
  final String id;
  final String name;
  final int colorCode;

  Tag(this.id, this.name, this.colorCode);
}

class Tags with ChangeNotifier {
  List<Tag> _defaultTags = [
    Tag('1', 'Dairy', AppColors.yellow.hashCode),
    Tag('2', 'Vegetable', AppColors.lightGreen.hashCode),
    Tag('3', 'Meat', AppColors.orange.hashCode),
  ];

  List<Tag> get defaultTags {
    return [..._defaultTags];
  }
}