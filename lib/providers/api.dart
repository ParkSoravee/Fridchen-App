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
    print('adding fridge item...');
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
          'cout_left': item.countLeft,
          'unit_id': item.unitIds,
          'min': item.min ?? 0,
          'exp': item.exp == null ? null : item.exp!.toIso8601String(),
          'tag_id': item.tagIds,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> editFridgeItem(
    // TODO: smart
    String familyId,
    FridgeItem item,
    String itemId,
  ) async {
    print('editing fridge item...');
    final url = Uri.parse(
      '$api_url/fridge_item/edit/family_id/$familyId/ingredient_id/$itemId',
    );
    try {
      final res = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'name': item.name,
          'cout_left': item.countLeft,
          'unit_id': item.unitIds,
          'min': item.min ?? 0,
          'exp': item.exp == null ? null : item.exp!.toIso8601String(),
          'tag_id': item.tagIds,
          // 'is_star' : item.isStar,
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
    print('consuming fridge item');
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

  Future<void> setExpFridgeItem(
    String familyId,
    FridgeItem item,
    DateTime exp,
  ) async {
    final url = Uri.parse(
      '$api_url/fridge_item/family_id/$familyId/ingredient_id/${item.id}',
    );
    try {
      print('set EXP');
      final res = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'exp': exp.toIso8601String(),
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> setStarFridgeItem(
    String familyId,
    FridgeItem item,
  ) async {
    print('set star');
    final url = Uri.parse(
      '$api_url/family_ingredient/set_is_star',
    );
    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "family_id": familyId,
          "ingredient_id": item.id,
          "is_star": !item.isStar,
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
    print('deleting fridge');
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
    print('creating recipe');
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
          'tag_ids': item.tagIds
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
    Recipe item,
  ) async {
    final url = Uri.parse(
      '$api_url/menu/menu_id/${item.id}',
    );
    try {
      print('updating recipe...');
      final res = await http.patch(
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
          'tag_ids': item.tagIds
              .map(
                (e) => e,
              )
              .toList(),
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteRecipeItem(
    String familyId,
    Recipe item,
  ) async {
    print('deleting menu...');
    final url = Uri.parse(
      '$api_url/menu/menu_id/${item.id}/family_id/$familyId',
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

  Future<void> pinRecipeItem(
    String familyId,
    Recipe item,
  ) async {
    print('pinning recipe');
    final url = Uri.parse(
      '$api_url/menu/set_is_pin',
    );
    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "family_id": familyId,
          "menu_id": item.id,
          "is_pin": !item.isPin,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> cookRecipeItem(
    String familyId,
    Recipe item,
  ) async {
    print('cooking recipe');
    final url = Uri.parse(
      '$api_url/menu/cook',
    );
    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "family_id": familyId,
          "menu_id": item.id,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // * List -----------------
  Future<void> addListItem(
    String familyId,
    ListItem item,
  ) async {
    print('adding shopping list');
    final url = Uri.parse(
      '$api_url/shopping_list/add_shopping_list',
    );
    try {
      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'name': item.name,
          'tag_id': item.tagIds,
          'family_id': familyId,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> tickListItem(
    String familyId,
    ListItem item,
    bool isTick,
  ) async {
    print('tick shopping list');
    final url = Uri.parse(
      '$api_url/shopping_list/family_id/$familyId/ingredient_id/${item.id}',
    );
    try {
      final res = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "is_bought": isTick,
        }),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> deleteListItem(
    String familyId,
    ListItem item,
  ) async {
    print('deleting shopping list');
    final url = Uri.parse(
      '$api_url/shopping_list/family_id/$familyId/ingredient_id/${item.id}',
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

  //
}
