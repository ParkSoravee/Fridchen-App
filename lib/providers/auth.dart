import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _userName;
  String? _userImg;

  bool get isAuth {
    return _userId != null;
  }

  String? get userId {
    return _userId;
  }

  String? get token {
    return _token;
  }

  String? get name {
    return _userName;
  }

  String? get img {
    return _userImg;
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.signInWithCredential(credential);
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userCredential.user;

    _userName = user!.displayName!;
    _userId = user.uid;
    _userImg = user.photoURL!;

    print(_userName);
    print(_userId);
    print(_userImg);

    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'userId': _userId,
      'userName': _userName,
      'userImg': _userImg,
    });
    prefs.setString('userData', userData);
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    print('try auto log...');
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        print('no data1');
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

      if (extractedUserData['userId'] == null) return;
      _userId = extractedUserData['userId']!;

      print('success auto login');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    _userId = null;
    _userName = null;
    _userImg = null;
    // await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().signOut();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('Logged out!');
  }
}
