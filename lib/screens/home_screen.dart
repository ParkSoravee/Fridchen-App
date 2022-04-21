import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:fridchen_app/screens/fridge_screen.dart';
import 'package:fridchen_app/screens/qrcode/add_member_screen.dart';
import 'package:fridchen_app/screens/recipe_screen.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/dialog_confirm.dart';
import 'package:provider/provider.dart';

import '../widgets/home_drawer.dart';
import '../widgets/home_menus.dart';
import '../widgets/row_with_title.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.green,
        ),
        child: HomeDrawer(),
      ),
      backgroundColor: AppColors.lightGreen,
      body: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            Container(
              // flex: 2,
              height: 160,
              child: FamilySelect(),
            ),
            Expanded(
              flex: 4,
              child: Menu(),
            ),
            Expanded(
              flex: 6,
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
    final fridchenFamily = Provider.of<Families>(context);
    final _form = GlobalKey<FormFieldState>();
    String fridchenName = '';

    Future<void> addNewFridchen() async {
      final isValid = _form.currentState!.validate();
      if (!isValid) return;
      _form.currentState!.save();

      try {
        await fridchenFamily.newFamily(fridchenName);
        // TODO call bottom success
      } catch (e) {
        print(e);
        // TODO call bottom error
      }
      Navigator.pop(context);
    }

    void addNewFridchenDialog() {
      showDialog(
        context: context,
        builder: (_) => DialogConfirm(
          title: 'New fridchen',
          primaryColor: AppColors.yellow,
          secondaryColor: AppColors.darkGreen,
          confirm: addNewFridchen,
          content: RowWithTitle(
            title: 'NAME :',
            isAlignStart: true,
            color: AppColors.white,
            child: [
              Expanded(
                child: TextFormField(
                  key: _form,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    filled: true,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 2),
                    hintText: 'Apartment',
                    hintStyle: TextStyle(
                      color: AppColors.white.withOpacity(0.2),
                      fontSize: 36,
                    ),
                  ),
                  cursorColor: AppColors.yellow,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 36,
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    addNewFridchen();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter fridchen name.';
                    }

                    if (value.length > 12) {
                      return 'Name can be only 1-12 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    fridchenName = value!.trim();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu_rounded,
                size: 40,
              ),
              color: AppColors.darkGreen,
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: FittedBox(
                child: Text(
                  'FRIDCHEN',
                  style: TextStyle(
                    // fontSize: 70,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
            ),
          ),
          // * Home select family
          Positioned(
            bottom: -19,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 78,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Spacer(),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    padding: EdgeInsets.only(
                      bottom: 4,
                    ),
                    splashRadius: 35,
                    iconSize: 45,
                    color: AppColors.darkGreen,
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: FittedBox(
                      child: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 65,
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.qrcode),
                    padding: EdgeInsets.only(
                      bottom: 8,
                    ),
                    splashRadius: 30,
                    iconSize: 33,
                    color: AppColors.darkGreen,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMemberScreen(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_rounded),
                    padding: EdgeInsets.only(
                      bottom: 8,
                    ),
                    splashRadius: 35,
                    iconSize: 60,
                    color: AppColors.darkGreen,
                    onPressed: addNewFridchenDialog,
                  ),
                  // Spacer(),
                ],
              ),
            ),
          ),
          // * ---- select family
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
          final size = constraints.maxWidth / 4.6;
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
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RecipeScreen(),
                    ),
                  );
                },
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
  const Recommend();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(80),
        ),
        color: AppColors.green,
      ),
      // padding: EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(35, 25, 25, 10),
            width: double.infinity,
            child: Text(
              'RECOMMEND',
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 2),
                    dense: true,
                    horizontalTitleGap: 12,
                    leading: Icon(
                      Icons.push_pin_rounded,
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
                    contentPadding: EdgeInsets.only(top: 2),
                    dense: true,
                    horizontalTitleGap: 12,
                    leading: Icon(
                      Icons.push_pin_rounded,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
