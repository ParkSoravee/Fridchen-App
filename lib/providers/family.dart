import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fridchen_app/providers/api.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// class Family {
//   final String? id;
//   final String name;
//   final List<Map<String, dynamic>> menus;

//   Family({
//     this.id,
//     required this.name,
//     required this.menus,
//   });
// }

class Families with ChangeNotifier {
  List<String> _families = [];

  int _currentFamilyIndex = 0;

  List<String> get families {
    return [..._families];
  }

  bool get hasFamily {
    return _families.isNotEmpty;
  }

  int get currentFamilyIndex {
    return _currentFamilyIndex;
  }

  String get currentFamilyId {
    return _families[_currentFamilyIndex];
  }

  void setCurrentFamily(int index) {
    if (index > _families.length - 1) return;
    _currentFamilyIndex = index;
  }

  Future<List<String>> fetchAndSetFamily(String userId) async {
    final api_url = dotenv.env['BACKEND_URL'];
    var url = Uri.parse(
      '$api_url/user/check_and_get_user?id=$userId',
    );
    print('fetching family ids by user');
    try {
      final res = await http.get(
        url,
      );
      final extractedData = json.decode(res.body)['data']['family_ids'];

      final familyIds = List<String>.from(extractedData);

      print(familyIds);

      _families = familyIds;

      return _families;
    } catch (e) {
      print('err: $e');
      throw e;
    }
  }

  Future<void> newFamily(String userId, String name,
      {bool first = false}) async {
    try {
      print('creating new family...');
      final api_url = dotenv.env['BACKEND_URL'];
      final url = Uri.parse(
        '$api_url/family/create_family/$userId',
      );

      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          "name": name,
        }),
      );
      final extractedData = (json.decode(res.body) as Map<String, dynamic>);
      // print(extractedData);
      _families =
          List<String>.from(extractedData['data']['user']['family_ids']);
      _currentFamilyIndex = _families.length - 1;
      if (first) notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> joinFamily(
    String userId,
    String familyId,
  ) async {
    try {
      print('joining family...');
      final api_url = dotenv.env['BACKEND_URL'];
      final url = Uri.parse(
        '$api_url/user/join/$familyId',
      );

      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          "user_id": userId,
        }),
      );
      final extractedData = (json.decode(res.body) as Map<String, dynamic>);
      // print(extractedData);
      _families = List<String>.from(extractedData['data']['family_ids']);
      _currentFamilyIndex = _families.length - 1;
    } catch (e) {
      print(e);
    }
  }

  Future<void> leaveFamily(String userId) async {
    final familyId = _families[_currentFamilyIndex];
    try {
      print('leaving family... $familyId');
      final api_url = dotenv.env['BACKEND_URL'];
      final url = Uri.parse(
        '$api_url/user/leave/$familyId',
      );

      final res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(<String, String>{
          "user_id": userId,
        }),
      );
      final extractedData = (json.decode(res.body) as Map<String, dynamic>);
      print(extractedData);
      if (_currentFamilyIndex > 0) _currentFamilyIndex -= 1;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
