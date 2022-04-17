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
      isStar: true,
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
        Tag('3', 'Vagetable', AppColors.lightGreen.hashCode),
        Tag('3', 'Vagetable', AppColors.lightGreen.hashCode),
      ],
    ),
  ];

  List<FridgeItem> get items {
    // TODO: sort by EXP date (and pick isStar to first)
    return [..._items];
  }

  List<FridgeItem> search(String? str, List<String> tags) {
    List<FridgeItem> searchItems = [..._items];
    if (tags.length > 0) {
      searchItems = searchItems.where((element) => element.tags.contains(tags))
          as List<FridgeItem>;
    }

    return searchItems;
  }

  void setStar(String id) {
    final selectItem = _items.firstWhere((element) => element.id == id);
    // set isStar
    selectItem.isStar = !selectItem.isStar;
    // rebuild notifylistener
    notifyListeners();
    // TODO save to DB
    // TODO socket
  }

  void delete(String id) {}
}
