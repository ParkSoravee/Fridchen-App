import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;

  bool get isAuth {
    return _userId != null;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    return _token;
  }

  Future<void> _authenticate() async {
    // TODO
  }
  Future<void> signup() async {
    _authenticate();
    // TODO
  }

  Future<void> login() async {
    // TODO
  }
  Future<void> logout() async {
    // TODO
  }
}
