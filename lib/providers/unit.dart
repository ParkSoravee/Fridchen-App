import 'package:flutter/material.dart';

import '../themes/color.dart';

class Unit {
  List<String> _items = [
    'Pieces',
    'Grams',
    'Kilograms',
    'Litre',
    'Millilitre',
    'Ounce',
    'CC',
    'Litre',
    'Millilitre',
    'Ounce',
    'CC',
    'Litre',
    'Millilitre',
    'Ounce',
    'CC',
    'Litre',
    'Millilitre',
    'Ounce',
    'CC',
  ];

  Unit();

  List<String> get items {
    return [..._items];
  }

  List<DropdownMenuItem<String>> getDropdownMenuItem(
      double fontSize, Color color) {
    return [...items].map<DropdownMenuItem<String>>((String value) {
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
