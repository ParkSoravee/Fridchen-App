import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fridchen_app/providers/tags.dart';
import 'package:fridchen_app/providers/unit.dart';

import '../themes/color.dart';

class Ingredient {
  final String name;
  final double amount;
  final String unitId;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unitId,
  });
}

class Recipe {
  final String? id;
  final String name;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final List<String> tagIds;
  bool isPin;

  Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.tagIds,
    this.isPin = false,
  });
}

class Recipes with ChangeNotifier {
  List<Recipe> _items = [
    // Recipe(
    //   id: '9999',
    //   name: 'Chocolate lava cake',
    //   isPin: true,
    //   ingredients: [
    //     Ingredient(
    //       name: 'Ingredient 1',
    //       amount: 200,
    //       unitId: '6268144dc5b8172fe1b14482',
    //     ),
    //     Ingredient(
    //       name: 'Ingredient 2',
    //       amount: 50,
    //       unitId: '626814a9c5b8172fe1b1448a',
    //     ),
    //     Ingredient(
    //       name: 'Ingredient 3',
    //       amount: 1000,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //   ],
    //   steps: [
    //     'step1 to do hello ',
    //     'step2 to do hello world asdasdasd',
    //     'step3 to do hello world',
    //     'step4 to do hello world asdsdsadasdasd',
    //     'step5 to do hello world asdasd',
    //   ],
    //   tagIds: [
    //     Tag('5', 'Dessert', AppColors.orange.hashCode),
    //     Tag('1', 'Dairy', AppColors.yellow.hashCode),
    //   ],
    // ),
    // Recipe(
    //   id: '8888',
    //   name: 'Fried pork with basil leaves',
    //   ingredients: [
    //     Ingredient(
    //       name: 'Ingredient 1',
    //       amount: 200,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //     Ingredient(
    //       name: 'Ingredient 2',
    //       amount: 50,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //     Ingredient(
    //       name: 'Ingredient 3',
    //       amount: 1000,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //   ],
    //   steps: [
    //     'step1 to do hello ',
    //     'step2 to do hello world asdasdasd',
    //     'step3 to do hello world',
    //     'step4 to do hello world asdsdsadasdasd',
    //     'step5 to do hello world asdasd',
    //   ],
    //   tagIds: [
    //     Tag('4', 'Fresh', AppColors.green.hashCode),
    //     Tag('3', 'Meat', AppColors.orange.hashCode),
    //     Tag('2', 'Vagetable', AppColors.lightGreen.hashCode),
    //   ],
    // ),
    // Recipe(
    //   id: '7777',
    //   name: 'Tom Yum Kung',
    //   ingredients: [
    //     Ingredient(
    //       name: 'Ingredient 1',
    //       amount: 200,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //     Ingredient(
    //       name: 'Ingredient 2',
    //       amount: 50,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //     Ingredient(
    //       name: 'Ingredient 3',
    //       amount: 1000,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //   ],
    //   steps: [
    //     'step1 to do hello ',
    //     'step2 to do hello world asdasdasd',
    //     'step3 to do hello world',
    //     'step4 to do hello world asdsdsadasdasd',
    //     'step5 to do hello world asdasd',
    //   ],
    //   tagIds: [
    //     Tag('5', 'Dessert', AppColors.orange.hashCode),
    //     Tag('1', 'Dairy', AppColors.yellow.hashCode),
    //   ],
    // ),
    // Recipe(
    //   id: '6666',
    //   name: 'Japanese omelette',
    //   ingredients: [
    //     Ingredient(
    //       name: 'Ingredient 1',
    //       amount: 200,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //     Ingredient(
    //       name: 'Ingredient 2',
    //       amount: 50,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //     Ingredient(
    //       name: 'Ingredient 3',
    //       amount: 1000,
    //       unitId: '6268143ac5b8172fe1b1447e',
    //     ),
    //   ],
    //   steps: [
    //     'step1 to do hello ',
    //     'step2 to do hello world asdasdasd',
    //     'step3 to do hello world',
    //     'step4 to do hello world asdsdsadasdasd',
    //     'step5 to do hello world asdasd',
    //   ],
    //   tagIds: [
    //     Tag('4', 'Fresh', AppColors.green.hashCode),
    //   ],
    // ),
  ];

  List<Recipe> get items {
    final items = [..._items];
    final stars = items.where((element) => element.isPin).toList();
    items.removeWhere((element) => element.isPin);

    items.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return stars + items;
  }

  Future<void> fetchAndSetItem(String familyId) async {
    try {
      final api_url = dotenv.env['BACKEND_URL'];
      final url = Uri.parse(
        '$api_url/menu/all/$familyId',
      );
      final res = await http.get(
        url,
      );

      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      print(extractedData['data']);
      final recipeItems =
          List<Map<String, dynamic>>.from(extractedData['data']);

      setRecipes(recipeItems);
    } catch (e) {
      print(e);
    }
  }

  void setRecipes(List<Map<String, dynamic>> items) {
    try {
      print('setting recipes...');
      _items = items.map((item) {
        return Recipe(
          id: item['menu_id'],
          name: item['menu_name'],
          isPin: item['is_pin'],
          steps: List<String>.from(item['steps']),
          ingredients: List<Ingredient>.from(
            (List<Map<String, dynamic>>.from(item['ingredients'])).map(
              (e) => Ingredient(
                name: e['ingredient_id'],
                amount: e['count'].toDouble(),
                unitId: e['unit_id'],
              ),
            ),
          ),
          tagIds: (List<Map<String, dynamic>>.from(item['tags']))
              .map((e) => e['tag_id'] as String)
              .toList(),
        );
      }).toList();
      print('success!!');
      notifyListeners();
    } catch (e) {
      print('e : $e');
    }
  }

  List<Recipe> search(String str, List<String> tags) {
    List<Recipe> searchItems = [..._items];
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

  void setPin(String id) {
    final selectItem = _items.firstWhere((element) => element.id == id);
    // set isStar
    selectItem.isPin = !selectItem.isPin;
    // rebuild notifylistener
    notifyListeners();
    // TODO save to DB
    // TODO socket
  }
}
