import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future<void> signin() async {
    Provider.of<Auth>(context, listen: false).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('signin'),
          onPressed: () async {
            await signin();
            print('signing in');
          },
        ),
      ),
    );
  }
}
