import 'package:flutter/material.dart';

class Unit {
  String id;
  String name;

  Unit({required this.id, required this.name});
}

class Units {
  List<Unit> _items = [
    Unit(
      id: '62681408c5b8172fe1b14476',
      name: 'Pieces',
    ),
    Unit(
      id: '626814a9c5b8172fe1b1448a',
      name: 'Grams',
    ),
    Unit(
      id: '62681434c5b8172fe1b1447c',
      name: 'Milligrams',
    ),
    Unit(
      id: '6268143ac5b8172fe1b1447e',
      name: 'Kilograms',
    ),
    Unit(
      id: '62681447c5b8172fe1b14480',
      name: 'Litre',
    ),
    Unit(
      id: '6268144dc5b8172fe1b14482',
      name: 'Millilitre',
    ),
    Unit(
      id: '62681458c5b8172fe1b14484',
      name: 'Ounce',
    ),
    Unit(
      id: '626814a3c5b8172fe1b14488',
      name: 'CC',
    ),
  ];

  Units();

  List<Unit> get items {
    return [..._items];
  }

  List<String> get itemsString {
    return _items.map((e) => e.name).toList();
  }

  String getNameById(String id) {
    return _items.firstWhere((element) => element.id == id).name;
  }

  String getIdByName(String name) {
    return _items.firstWhere((element) => element.name == name).id;
  }

  List<DropdownMenuItem<String>> getDropdownMenuItem(
      double fontSize, Color color) {
    return itemsString.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
          ),
        ),
      );
    }).toList();
  }
}
