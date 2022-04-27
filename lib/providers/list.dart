import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/tags.dart';

class ListItem {
  final String? id;
  final String name;
  final List<String> tagIds;
  bool isTick;

  ListItem({
    this.id,
    required this.name,
    required this.tagIds,
    this.isTick = false,
  });
}

class ListItems with ChangeNotifier {
  List<ListItem> _items = [
    //   ListItem(
    //     id: '1',
    //     name: 'Butter',
    //     tagIds: [
    //       Tag('1', 'Dairy', AppColors.yellow.hashCode),
    //     ],
    //   ),
    //   ListItem(
    //     id: '2',
    //     isTick: true,
    //     name: 'Chicken',
    //     tagIds: [
    //       Tag('4', 'Fresh', AppColors.green.hashCode),
    //     ],
    //   ),
    //   ListItem(
    //     id: '34567',
    //     name: 'Bok choy',
    //     tagIds: [
    //       Tag('4', 'Fresh', AppColors.green.hashCode),
    //       Tag('2', 'Vagetable', AppColors.lightGreen.hashCode),
    //     ],
    //   ),
  ];

  List<ListItem> get items {
    return [..._items];
  }

  void setListItem(List<Map<String, dynamic>> items) {
    try {
      _items = items.map((item) {
        return ListItem(
          id: item['ingredient_id'],
          name: item['ingredient_name'],
          tagIds: (List<Map<String, dynamic>>.from(item['tags']))
              .map((e) => e['tag_id'] as String)
              .toList(),
        );
      }).toList();
      print('success!!');
    } catch (e) {
      print('e: $e');
    }
  }

  List<ListItem> search(String str, List<String> tags) {
    List<ListItem> searchItems = [..._items];
    if (tags.length > 0) {
      for (int i = 0; i < tags.length; i++) {
        searchItems = searchItems
            .where(
              (item) => item.tagIds.any(
                (tag) => tags[i] == tag,
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
