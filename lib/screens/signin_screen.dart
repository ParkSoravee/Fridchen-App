import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';
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
      backgroundColor: AppColors.darkGreen,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 60,
            ),
            alignment: Alignment.topCenter,
            child: Text(
              'WELCOME\nTO FRIDCHEN!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.yellow,
                fontSize: 64,
                // height: 1.2,
              ),
            ),
          ),
          Center(
            child: OutlinedButton(
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                padding: EdgeInsets.fromLTRB(0, 10, 7, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/google_icon.png',
                      height: 60,
                      width: 60,
                    ),
                    Text(
                      'Sign in with Google',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 30,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () async {
                await signin();
                print('signing in');
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.white,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
