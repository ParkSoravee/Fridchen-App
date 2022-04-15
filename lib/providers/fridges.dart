import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/tags.dart';
import 'package:fridchen_app/themes/color.dart';

class FridgeItem {
  final String id;
  String name;
  double countLeft;
  String unit;
  DateTime? exp;
  List<Tag> tags;
  bool isStar;

  FridgeItem({
    required this.id,
    required this.name,
    required this.countLeft,
    required this.unit,
    this.exp,
    this.tags = const [],
    this.isStar = false,
  });
}

class FridgeItems with ChangeNotifier {
  List<FridgeItem> _items = [
    FridgeItem(
      id: '12345',
      name: 'Milk',
      countLeft: 0.5,
      unit: 'Litre',
      exp: DateTime(2022, 2, 11),
      tags: [
        Tag('1', 'Fresh', AppColors.green.hashCode),
        Tag('2', 'Dairy', AppColors.yellow.hashCode),
      ],
    ),
    FridgeItem(
      id: '23456',
      name: 'Pork',
      countLeft: 200,
      unit: 'Grams',
      exp: DateTime(2022, 2, 13),
      tags: [
        Tag('1', 'Fresh', AppColors.green.hashCode),
        Tag('2', 'Meat', AppColors.orange.hashCode),
      ],
    ),
  ];

  List<FridgeItem> get items {
    return [..._items];
  }
}
