import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fridchen_app/providers/api.dart';
import 'package:fridchen_app/providers/auth.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/providers/list.dart';
import 'package:fridchen_app/providers/recipes.dart';
import 'package:fridchen_app/screens/home_screen.dart';
import 'package:fridchen_app/socket.dart';
import 'package:provider/provider.dart';

import 'providers/tags.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  // MySocket.initSocket();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Families(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FridgeItems(),
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
            auth.userId,
            auth.token,
          ),
          create: (_) => Api(
            Provider.of<Auth>(context, listen: false).userId,
            Provider.of<Auth>(context, listen: false).token,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Fridchen',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'BebasNeue',
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}
