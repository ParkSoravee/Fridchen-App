import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/tags.dart';
import 'package:fridchen_app/providers/unit.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:provider/provider.dart';

class FridgeItem {
  final String? id;
  String name;
  double countLeft;
  double? min;
  String unitIds;
  DateTime? exp;
  List<String> tagIds;
  bool isStar;

  FridgeItem({
    this.id,
    required this.name,
    required this.countLeft,
    required this.unitIds,
    this.min,
    this.exp,
    this.tagIds = const [],
    this.isStar = false,
  });
}

class FridgeItems with ChangeNotifier {
  List<FridgeItem> _items = [
    // FridgeItem(
    //   id: '12345',
    //   name: 'Milk',
    //   countLeft: 5,
    //   min: 10,
    //   unit: Unit(
    //     id: '62681408c5b8172fe1b14476',
    //     name: 'Pieces',
    //   ),
    //   isStar: true,
    //   exp: DateTime(2022, 2, 11),
    //   tagIds: [
    //     // Tag('4', 'Fresh', AppColors.green.hashCode),
    //     // Tag('1', 'Dairy', AppColors.yellow.hashCode),
    //     '6267c066c1550ec4cddf83a4',
    //     '6267c066c1550ec4cddf83a6'
    //   ],
    // ),
    // FridgeItem(
    //   id: '23456',
    //   name: 'Pork',
    //   countLeft: 200,
    //   min: 100,
    //   unit: Unit(
    //     id: '62681408c5b8172fe1b14476',
    //     name: 'Pieces',
    //   ),
    //   exp: DateTime(2022, 2, 13),
    //   tagIds: ['6267c066c1550ec4cddf83a6'],
    // ),
    // FridgeItem(
    //   id: '34567',
    //   name: 'Bok Choy',
    //   countLeft: 100,
    //   unit: 'Grams',
    //   exp: DateTime(2022, 2, 8),
    //   tags: [
    //     Tag('2', 'Vagetable', AppColors.lightGreen.hashCode),
    //     Tag('4', 'Fresh', AppColors.green.hashCode),
    //   ],
    // ),
    // FridgeItem(
    //   id: '45678',
    //   name: 'Kochujang',
    //   countLeft: 1,
    //   unit: 'Piece',
    //   tags: [
    //     Tag('5', 'Seasoning', AppColors.yellow.hashCode),
    //   ],
    // ),
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
              (item) => item.tagIds.any(
                // (tag) => tags.contains(tag.id),
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

  void setItem(List<Map<String, dynamic>> items) {
    try {
      _items = items.map((item) {
        // print(item['ingredient_id'].runtimeType);
        // print(item['ingredient_name']);
        // print('min: ${item['min'].runtimeType}');
        // print('count: ${item['cout_left'].runtimeType}');
        // print('${item['unit_id'].runtimeType}');
        // print('${item['unit_name'].runtimeType}');
        // print('${item['is_star'].runtimeType}');
        // print('------');
        // return FridgeItem(
        //     name: 'test', countLeft: 0, unit: Unit(id: '123', name: 'test'));
        return FridgeItem(
          id: item['ingredient_id'],
          name: item['ingredient_name'],
          min: item['min'] == null ? null : item['min'].toDouble(),
          countLeft: item['cout_left'].toDouble(),
          // countLeft: 11.0,
          unitIds: item['unit_id'],
          isStar: item['is_star'],
          exp: item['exp'] != null ? DateTime.parse(item['exp']) : null,
          tagIds: (List<Map<String, dynamic>>.from(item['tags']))
              .map((e) => e['tag_id'] as String)
              .toList(),
          // tags: [],
        );
      }).toList();
      print('success!!');
      // final newItem = ;
    } catch (e) {
      print('e: $e');
    }
  }

  Future<void> setStar(String id) async {
    final selectItem = _items.firstWhere((element) => element.id == id);
    // set isStar
    selectItem.isStar = !selectItem.isStar;
    // rebuild notifylistener
    notifyListeners();
    // TODO api
    // TODO save to DB
  }

  void setExp(String id, DateTime date) {
    try {
      final selectItem = _items.firstWhere((element) => element.id == id);
      selectItem.exp = date;
      notifyListeners();
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
      throw e;
    }
  }

  Future<void> addNewItem(FridgeItem item) async {
    try {
      print('saved!');
      // TODO API
    } catch (e) {
      throw e; // TODO: throw no internet connection
    }
  }

  void consumeItem(String id, double amount) {
    try {
      final item = _items.firstWhere((element) => element.id == id);
      final isEmpty =
          double.parse((item.countLeft - amount).toStringAsFixed(2)) <= 0;
      final isStar = item.isStar;

      // check is going to pass the min value? if star API add to list
      if (isStar && item.min != null) {
        final isPassMin =
            item.countLeft > item.min! && item.countLeft - amount <= item.min!;
        if (isPassMin) {
          print('add to list');
          // TODO: API add to list
        }
      }
      // if not empty? API update : API delete
      if (!isEmpty) {
        final newItem = FridgeItem(
          id: item.id,
          name: item.name,
          countLeft: double.parse((item.countLeft - amount).toStringAsFixed(2)),
          unitIds: item.unitIds,
        );
        print(
            'update left: ${double.parse((item.countLeft - amount).toStringAsFixed(2))}');
        // TODO: API update
      } else {
        print('delete');
        // TODO: API delete
      }
    } catch (e) {
      throw e; // TODO: throw no internet connection
    }
  }
}
