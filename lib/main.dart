import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fridchen_app/providers/api.dart';
import 'package:fridchen_app/providers/auth.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/providers/list.dart';
import 'package:fridchen_app/providers/recipes.dart';
import 'package:fridchen_app/providers/unit.dart';
import 'package:fridchen_app/screens/fetch_family_screen.dart';
import 'package:fridchen_app/screens/home_screen.dart';
import 'package:fridchen_app/screens/signin_screen.dart';
import 'package:fridchen_app/socket.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'providers/tags.dart';
import 'screens/splash_screen.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // MySocket.initSocket();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => FridgeItems(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Units(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Recipes(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ListItems(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Tags(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Api>(
          update: (ctx, auth, pre) => Api(
            userId: auth.userId,
            authToken: auth.token,
          ),
          create: (_) => Api(
            userId: Provider.of<Auth>(context, listen: false).userId,
            authToken: Provider.of<Auth>(context, listen: false).token,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Families(),
        ),
        // ChangeNotifierProxyProvider<Api, Families>(
        //   update: (ctx, api, pre) => Families(api),
        //   create: (_) => Families(null),
        // ),
      ],
      builder: (context, _) => Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Fridchen',
          theme: ThemeData(
            primarySwatch: Colors.green,
            fontFamily: 'BebasNeue',
          ),
          debugShowCheckedModeBanner: false,
          home: auth.isAuth
              ? FetchFamilyScreen(auth.userId!)
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : SignInScreen(),
                ),
        ),
      ),
    );
  }
}
