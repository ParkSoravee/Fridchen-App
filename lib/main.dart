import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
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
