import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/providers/list.dart';
import 'package:fridchen_app/providers/recipes.dart';
import 'package:http/http.dart' as http;

class Api with ChangeNotifier {
  final String? userId;
  final String? authToken;
  final api_url = dotenv.env['BACKEND_URL'];

  Api(this.userId, this.authToken);

  // * Fridchen/Family
  Future<String> addNewFridchen(
    Family item,
  ) async {
    final url = Uri.parse(
      '$api_url/family?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'name': item.name,
        }),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      return extractedData['id'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<String> joinFridchen(
    Family item,
  ) async {
    final url = Uri.parse(
      '$api_url/family/join?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'id': item.id,
        }),
      );
      final extractedData = json.decode(res.body) as Map<String, dynamic>;

      return extractedData['id'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // * Fridge
  Future<void> addFridgeItem(
    FridgeItem item,
  ) async {
    final url = Uri.parse(
      '$api_url/fridge/add?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'name': item.name,
          'countLeft': item.countLeft,
          'unit': item.unit,
          'min': item.min,
          'exp': item.exp == null ? null : item.exp!.toIso8601String(),
          'tags': item.tags
              .map((e) => {
                    'id': e.id,
                    'name': e.name,
                    'colorCode': e.colorCode,
                  })
              .toList(),
          'isStar': item.isStar,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateFridgeItem(
    FridgeItem item,
  ) async {
    final url = Uri.parse(
      '$api_url/fridge/update?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'id': item.id,
          'name': item.name,
          'countLeft': item.countLeft,
          'unit': item.unit,
          'min': item.min,
          'exp': item.exp == null ? null : item.exp!.toIso8601String(),
          'tags': item.tags
              .map((e) => {
                    'id': e.id,
                    'name': e.name,
                    'colorCode': e.colorCode,
                  })
              .toList(),
          'isStar': item.isStar,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteFridgeItem(
    FridgeItem item,
  ) async {
    final url = Uri.parse(
      '$api_url/fridge/delete?userid=$userId',
    );
    try {
      final res = await http.delete(
        url,
        body: json.encode({
          'id': item.id,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // * Recipe -----------------
  Future<void> addRecipeItem(
    Recipe item,
  ) async {
    final url = Uri.parse(
      '$api_url/recipe/add?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'name': item.name,
          'ingredients': item.ingredients
              .map((e) => {
                    'name': e.name,
                    'amount': e.amount,
                    'unit': e.unit,
                  })
              .toList(),
          'steps': item.steps.map((step) => step).toList(),
          'tags': item.tags
              .map((e) => {
                    'id': e.id,
                    'name': e.name,
                    'colorCode': e.colorCode,
                  })
              .toList(),
          'isPin': item.isPin,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateRecipeItem(
    Recipe item,
  ) async {
    final url = Uri.parse(
      '$api_url/recipe/update?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'id': item.id,
          'name': item.name,
          'ingredients': item.ingredients
              .map((e) => {
                    'name': e.name,
                    'amount': e.amount,
                    'unit': e.unit,
                  })
              .toList(),
          'steps': item.steps.map((step) => step).toList(),
          'tags': item.tags
              .map((e) => {
                    'id': e.id,
                    'name': e.name,
                    'colorCode': e.colorCode,
                  })
              .toList(),
          'isPin': item.isPin,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteRecipeItem(
    Recipe item,
  ) async {
    final url = Uri.parse(
      '$api_url/recipe/delete?userid=$userId',
    );
    try {
      final res = await http.delete(
        url,
        body: json.encode({
          'id': item.id,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> pinRecipeItem(
    Recipe item,
  ) async {
    final url = Uri.parse(
      '$api_url/recipe/pin?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'id': item.id,
          'isPin': item.isPin,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // * List -----------------
  Future<void> addListItem(
    ListItem item,
  ) async {
    final url = Uri.parse(
      '$api_url/list/add?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'name': item.name,
          'tags': item.tags
              .map((e) => {
                    'id': e.id,
                    'name': e.name,
                    'colorCode': e.colorCode,
                  })
              .toList(),
          'isTick': item.isTick
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateListItem(
    ListItem item,
  ) async {
    final url = Uri.parse(
      '$api_url/list/update?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'id': item.id,
          'isTick': item.isTick,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteListItem(
    ListItem item,
  ) async {
    final url = Uri.parse(
      '$api_url/list/delete?userid=$userId',
    );
    try {
      final res = await http.delete(
        url,
        body: json.encode({
          'id': item.id,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  //
}
