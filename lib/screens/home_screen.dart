import 'package:flutter/material.dart';
import 'package:fridchen_app/screens/fridge_screen.dart';
import 'package:fridchen_app/themes/color.dart';

import '../widgets/home_drawer.dart';
import '../widgets/home_menus.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      backgroundColor: AppColors.lightGreen,
      body: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: FamilySelect(),
            ),
            Expanded(
              flex: 3,
              child: Menu(),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    color: AppColors.darkGreen,
                  ),
                  Recommend(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FamilySelect extends StatelessWidget {
  const FamilySelect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          ),
          Text('FRIDCHEN'),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
        color: AppColors.darkGreen,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.maxHeight / 3.3;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FridgeScreen(),
                    ),
                  );
                },
                child: Menus(
                  image: 'assets/images/fridge.png',
                  title: 'FRIDGE',
                  color: AppColors.lightGreen,
                  size: size,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Menus(
                  image: 'assets/images/recipe.png',
                  title: 'RECIPE',
                  color: AppColors.orange,
                  size: size,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Menus(
                  image: 'assets/images/list.png',
                  title: 'LIST',
                  color: AppColors.yellow,
                  size: size,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Recommend extends StatelessWidget {
  const Recommend({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
        color: AppColors.green,
      ),
    );
  }
}
