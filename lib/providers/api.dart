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

  Api({this.userId, this.authToken});

  // * Fridchen/Family
  // Future<Map<String, dynamic>> getFamilyData(String familyId) async {

  // }

  // Future<String> addNewFridchen(
  //   Family item,
  // ) async {
  //   final url = Uri.parse(
  //     '$api_url/family?userid=$userId',
  //   );
  //   try {
  //     final res = await http.post(
  //       url,
  //       body: json.encode({
  //         'name': item.name,
  //       }),
  //     );
  //     final extractedData = json.decode(res.body) as Map<String, dynamic>;

  //     return extractedData['id'];
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  // Future<String> joinFridchen(
  //   Family item,
  // ) async {
  //   final url = Uri.parse(
  //     '$api_url/family/join?userid=$userId',
  //   );
  //   try {
  //     final res = await http.post(
  //       url,
  //       body: json.encode({
  //         'id': item.id,
  //       }),
  //     );
  //     final extractedData = json.decode(res.body) as Map<String, dynamic>;

  //     return extractedData['id'];
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  // * Fridge
  Future<void> addFridgeItem(
    String familyId,
    FridgeItem item,
  ) async {
    final url = Uri.parse(
      '$api_url/fridge_item/add_fridge_item',
    );
    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'family_id': familyId,
          'name': item.name,
          'count': item.countLeft,
          'unit_id': item.unit.id,
          'min': item.min,
          'exp': item.exp == null
              ? null
              : item.exp!.toIso8601String(), // TODO: smart
          'tags': item.tagIds,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> consumeFridgeItem(
    String familyId,
    FridgeItem item,
    double consume,
  ) async {
    final url = Uri.parse(
      '$api_url/fridge_item/family_id/$familyId/ingredient_id/${item.id}',
    );
    try {
      final res = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'cout_left': item.countLeft - consume,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteFridgeItem(
    String familyId,
    FridgeItem item,
  ) async {
    final url = Uri.parse(
      '$api_url/fridge_item/family_id/$familyId/ingredient_id/${item.id}',
    );
    try {
      final res = await http.delete(
        url,
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // * Recipe -----------------
  Future<void> addRecipeItem(
    String familyId,
    Recipe item,
  ) async {
    final url = Uri.parse(
      '$api_url/menu/create_menu',
    );
    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'family_id': familyId,
          'name': item.name,
          'ingredients': item.ingredients
              .map((e) => {
                    'name': e.name,
                    'count': e.amount,
                    'unit_id': e.unitId,
                  })
              .toList(),
          'steps': item.steps,
          'tags': item.tagIds
              .map(
                (e) => e,
              )
              .toList(),
          // 'isPin': item.isPin,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateRecipeItem(
    // TODO: smart
    Recipe item,
  ) async {
    final url = Uri.parse(
      '$api_url/recipe/update?userid=$userId',
    );
    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'id': item.id,
          'name': item.name,
          'ingredients': item.ingredients
              .map((e) => {
                    'name': e.name,
                    'amount': e.amount,
                    'unit': e.unitId,
                  })
              .toList(),
          'steps': item.steps.map((step) => step).toList(),
          // 'tags': item.tagIds
          //     .map((e) => {
          //           'id': e.id,
          //           'name': e.name,
          //           'colorCode': e.colorCode,
          //         })
          //     .toList(),
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
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
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
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'name': item.name,
          'tags': item.tagIds,
          'isTick': item.isTick,
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
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
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
