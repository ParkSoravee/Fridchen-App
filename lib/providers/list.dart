import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/tags.dart';

import '../themes/color.dart';

class ListItem {
  final String? id;
  final String name;
  final List<Tag> tags;
  bool isTick;

  ListItem({
    this.id,
    required this.name,
    required this.tags,
    this.isTick = false,
  });
}

class ListItems with ChangeNotifier {
  List<ListItem> _items = [
    ListItem(
      id: '1',
      name: 'Butter',
      tags: [
        Tag('1', 'Dairy', AppColors.yellow.hashCode),
      ],
    ),
    ListItem(
      id: '2',
      isTick: true,
      name: 'Chicken',
      tags: [
        Tag('4', 'Fresh', AppColors.green.hashCode),
      ],
    ),
    ListItem(
      id: '34567',
      name: 'Bok choy',
      tags: [
        Tag('4', 'Fresh', AppColors.green.hashCode),
        Tag('2', 'Vagetable', AppColors.lightGreen.hashCode),
      ],
    ),
  ];

  List<ListItem> get items {
    return [..._items];
  }

  List<ListItem> search(String str, List<String> tags) {
    List<ListItem> searchItems = [..._items];
    if (tags.length > 0) {
      for (int i = 0; i < tags.length; i++) {
        searchItems = searchItems
            .where(
              (item) => item.tags.any(
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

  Future<void> addNewItem(String name, List<Tag> tags) async {
    try {
      final isValid = _items.indexWhere(
            (element) => element.name.toLowerCase() == name.toLowerCase(),
          ) !=
          -1;
      if (isValid) return;
      print('saving');
      // TODO api
    } catch (e) {
      throw e;
    }
  }

  void deleteItem(String id) {
    final backupItem = _items.firstWhere((element) => element.id == id);
    final backupItemIndex = _items.indexWhere((element) => element.id == id);
    _items.removeWhere((element) => element.id == id);
    try {
      // delete
      // TODO api
      notifyListeners();
    } catch (e) {
      _items.insert(backupItemIndex, backupItem);
      print(e);
      throw e;
    }
  }

  void setTick(String id) {
    final selectItem = _items.firstWhere((element) => element.id == id);
    // set isStar
    selectItem.isTick = !selectItem.isTick;
    // rebuild notifylistener
    // notifyListeners();
    // TODO save to DB
    // TODO api
  }
}
