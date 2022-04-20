import 'package:flutter/material.dart';

class Family {
  final String id;
  final String name;
  final String code;
  final List<Map<String, dynamic>> menus;

  Family({
    required this.id,
    required this.name,
    required this.code,
    required this.menus,
  });
}

class Families with ChangeNotifier {
  List<Family> _families = [
    Family(
      id: '123456',
      name: 'Home1',
      code: '1234',
      menus: [
        {'id': '1234', 'isPin': true},
      ],
    ),
    Family(
      id: '234567',
      name: 'Home2',
      code: '2345',
      menus: [
        {'id': '2345', 'isPin': true},
      ],
    ),
    Family(
      id: '345678',
      name: 'Home3',
      code: '3456',
      menus: [
        {'id': '3456', 'isPin': true},
      ],
    ),
  ];
  // final String userId;
  // final String authToken;

  // Families(this._families, this.userId);

  List<Family> get families {
    return [..._families];
  }

  Future<void> newFamily(String name) async {
    try {
      // add _families
      // post api
      print(name);
    } catch (e) {
      print(e);
    }
  }
}
