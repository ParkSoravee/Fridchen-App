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
        Tag('4', 'Fresh', AppColors.green.hashCode),
        Tag('1', 'Dairy', AppColors.yellow.hashCode),
      ],
    ),
    FridgeItem(
      id: '23456',
      name: 'Pork',
      countLeft: 200,
      unit: 'Grams',
      exp: DateTime(2022, 2, 13),
      tags: [
        Tag('3', 'Meat', AppColors.orange.hashCode),
        Tag('2', 'Vagetable', AppColors.lightGreen.hashCode),
        Tag('4', 'Fresh', AppColors.green.hashCode),
      ],
    ),
    FridgeItem(
      id: '34567',
      name: 'Bok Choy',
      countLeft: 100,
      unit: 'Grams',
      exp: DateTime(2022, 2, 8),
      tags: [
        Tag('2', 'Vagetable', AppColors.lightGreen.hashCode),
        Tag('4', 'Fresh', AppColors.green.hashCode),
      ],
    ),
    FridgeItem(
      id: '45678',
      name: 'Kochujang',
      countLeft: 1,
      unit: 'Piece',
      tags: [
        Tag('5', 'Seasoning', AppColors.yellow.hashCode),
      ],
    ),
  ];

  List<FridgeItem> get items {
    // sort by EXP date (and pick isStar to first)
    final items = [..._items];
    final stars = items.where((element) => element.isStar).toList();
    items.removeWhere((element) => element.isStar);

    final noExps = items.where((element) => element.exp == null).toList();
    items.removeWhere((element) => element.exp == null);

    items.sort((a, b) => a.exp!.compareTo(b.exp!));

    return stars + noExps + items;
  }

  List<FridgeItem> search(String str, List<String> tags) {
    List<FridgeItem> searchItems = [..._items];
    if (tags.length > 0) {
      for (int i = 0; i < tags.length; i++) {
        searchItems = searchItems
            .where(
              (item) => item.tags.any(
                // (tag) => tags.contains(tag.id),
                (tag) => tags[i] == tag.id,
              ),
            )
            .toList();
      }
    }

    if (str != '') {
      searchItems = searchItems
          .where((element) =>
              element.name.toLowerCase().contains(str.toLowerCase()))
          .toList();
    }

    return [...searchItems];
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

  void setExp(String id, DateTime date) {
    final selectItem = _items.firstWhere((element) => element.id == id);
    selectItem.exp = date;
    notifyListeners();
    // TODO save to DB
    // TODO socket
  }

  void deleteItem(String id) {
    // TODO save to DB
    // TODO socket
  }

  void addItem() {
    // * how to gen id??
    // TODO save to DB
    // TODO socket
  }
}
