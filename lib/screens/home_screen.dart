import 'package:flutter/material.dart';
import 'package:fridchen_app/screens/fridge_screen.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/dialog_confirm.dart';

import '../widgets/home_drawer.dart';
import '../widgets/home_menus.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: HomeDrawer(),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.green,
          ),
          child: homedrawer()),
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
          Stack(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu, size: 40),
                  color: AppColors.darkGreen,
                ),
              ),
              Center(
                child: Text('FRIDCHEN',
                    style: TextStyle(
                      fontSize: 70,
                      color: AppColors.darkGreen,
                    )),
              ),
            ],
          ),
          // Spacer(),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                SizedBox(width: 40),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  iconSize: 40,
                  color: AppColors.darkGreen,
                  onPressed: () {},
                ),
                SizedBox(width: 30),
                Text(
                  'HOME',
                  style: TextStyle(
                    fontSize: 60,
                    color: AppColors.darkGreen,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  iconSize: 40,
                  color: AppColors.darkGreen,
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => QRScreen(),
                    //     ));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 50,
                  color: AppColors.darkGreen,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => Popup_confirm(
                        texttitle: 'NEW FRIDCHEN',
                        primaryColor: AppColors.darkGreen,
                        secondaryColor: AppColors.yellow,
                        titletextColor: Colors.white,
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "NAME :",
                              style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                  fontFamily: "BebasNeue")),
                          TextSpan(
                              text: " FAVORITE            ",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Color.fromARGB(255, 252, 202, 70),
                                  fontFamily: "BebasNeue")),
                        ])),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 20),
            width: double.infinity,
            child: Text(
              'RECOMMEND',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                ListTile(
                  leading: Icon(
                    Icons.push_pin,
                    size: 40,
                    color: AppColors.darkGreen,
                  ),
                  title: const Text(
                    'CHOCOLATE LAVA CAKE',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.push_pin,
                    size: 40,
                    color: AppColors.yellow,
                  ),
                  title: const Text(
                    'CHOCOLATE LAVA CAKE',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.push_pin,
                    size: 40,
                    color: AppColors.darkGreen,
                  ),
                  title: const Text(
                    'CHOCOLATE LAVA CAKE',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.push_pin,
                    size: 40,
                    color: AppColors.yellow,
                  ),
                  title: const Text(
                    'CHOCOLATE LAVA CAKE',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.push_pin,
                    size: 40,
                    color: AppColors.darkGreen,
                  ),
                  title: const Text(
                    'CHOCOLATE LAVA CAKE',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.push_pin,
                    size: 40,
                    color: AppColors.yellow,
                  ),
                  title: const Text(
                    'CHOCOLATE LAVA CAKE',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
