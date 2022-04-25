import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/tags.dart';

import '../themes/color.dart';

class Ingredient {
  final String name;
  final double amount;
  final String unit;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
  });
}

class Recipe {
  final String? id;
  final String name;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final List<Tag> tags;
  bool isPin;

  Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.tags,
    this.isPin = false,
  });
}

class Recipes with ChangeNotifier {
  List<Recipe> _items = [
    Recipe(
      id: '9999',
      name: 'Chocolate lava cake',
      isPin: true,
      ingredients: [
        Ingredient(
          name: 'Ingredient 1',
          amount: 200,
          unit: 'Millilitres',
        ),
        Ingredient(
          name: 'Ingredient 2',
          amount: 50,
          unit: 'Grams',
        ),
        Ingredient(
          name: 'Ingredient 3',
          amount: 1000,
          unit: 'Kilograms',
        ),
      ],
      steps: [
        'step1 to do hello ',
        'step2 to do hello world asdasdasd',
        'step3 to do hello world',
        'step4 to do hello world asdsdsadasdasd',
        'step5 to do hello world asdasd',
      ],
      tags: [
        Tag('5', 'Dessert', AppColors.orange.hashCode),
        Tag('1', 'Dairy', AppColors.yellow.hashCode),
      ],
    ),
    Recipe(
      id: '8888',
      name: 'Fried pork with basil leaves',
      ingredients: [
        Ingredient(
          name: 'Ingredient 1',
          amount: 200,
          unit: 'Millilitres',
        ),
        Ingredient(
          name: 'Ingredient 2',
          amount: 50,
          unit: 'Grams',
        ),
        Ingredient(
          name: 'Ingredient 3',
          amount: 1000,
          unit: 'Kilograms',
        ),
      ],
      steps: [
        'step1 to do hello ',
        'step2 to do hello world asdasdasd',
        'step3 to do hello world',
        'step4 to do hello world asdsdsadasdasd',
        'step5 to do hello world asdasd',
      ],
      tags: [
        Tag('4', 'Fresh', AppColors.green.hashCode),
        Tag('3', 'Meat', AppColors.orange.hashCode),
        Tag('2', 'Vagetable', AppColors.lightGreen.hashCode),
      ],
    ),
    Recipe(
      id: '7777',
      name: 'Tom Yum Kung',
      ingredients: [
        Ingredient(
          name: 'Ingredient 1',
          amount: 200,
          unit: 'Millilitres',
        ),
        Ingredient(
          name: 'Ingredient 2',
          amount: 50,
          unit: 'Grams',
        ),
        Ingredient(
          name: 'Ingredient 3',
          amount: 1000,
          unit: 'Kilograms',
        ),
      ],
      steps: [
        'step1 to do hello ',
        'step2 to do hello world asdasdasd',
        'step3 to do hello world',
        'step4 to do hello world asdsdsadasdasd',
        'step5 to do hello world asdasd',
      ],
      tags: [
        Tag('5', 'Dessert', AppColors.orange.hashCode),
        Tag('1', 'Dairy', AppColors.yellow.hashCode),
      ],
    ),
    Recipe(
      id: '6666',
      name: 'Japanese omelette',
      ingredients: [
        Ingredient(
          name: 'Ingredient 1',
          amount: 200,
          unit: 'Millilitres',
        ),
        Ingredient(
          name: 'Ingredient 2',
          amount: 50,
          unit: 'Grams',
        ),
        Ingredient(
          name: 'Ingredient 3',
          amount: 1000,
          unit: 'Kilograms',
        ),
      ],
      steps: [
        'step1 to do hello ',
        'step2 to do hello world asdasdasd',
        'step3 to do hello world',
        'step4 to do hello world asdsdsadasdasd',
        'step5 to do hello world asdasd',
      ],
      tags: [
        Tag('4', 'Fresh', AppColors.green.hashCode),
      ],
    ),
  ];

  List<Recipe> get items {
    final items = [..._items];
    final stars = items.where((element) => element.isPin).toList();
    items.removeWhere((element) => element.isPin);

    items.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return stars + items;
  }

  List<Recipe> search(String str, List<String> tags) {
    List<Recipe> searchItems = [..._items];
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
