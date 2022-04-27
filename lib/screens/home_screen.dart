import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fridchen_app/providers/api.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:fridchen_app/screens/fridge_screen.dart';
import 'package:fridchen_app/screens/list_screen.dart';
import 'package:fridchen_app/screens/qrcode/add_member_screen.dart';
import 'package:fridchen_app/screens/recipe_screen.dart';
import 'package:fridchen_app/screens/splash_screen.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/dialog_confirm.dart';
import 'package:fridchen_app/widgets/dialog_new_fridchen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../widgets/home_drawer.dart';
import '../widgets/home_menus.dart';
import '../widgets/row_with_title.dart';

class MyHomePage extends StatefulWidget {
  final List<String> familyIds;
  final String userId;

  MyHomePage(this.familyIds, this.userId);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final api_url = dotenv.env['BACKEND_URL'];
  int _index = 0;
  bool _isLoading = true;
  bool _isInit = false;
  late List<String> _familyIds;
  late String _familyName;

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  Future<void> addNewFridchen(String name) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Families>(context, listen: false)
          .newFamily(widget.userId, name);
      await Provider.of<Families>(context, listen: false)
          .fetchAndSetFamily(widget.userId);
      _index += 1;
      // Provider.of<Families>(context, listen: false).setCurrentFamily(_index);
      await getAllData();
      // TODO call bottom success
    } catch (e) {
      print(e);
      // setState(() {
      //   _isLoading = false;
      // });
      // TODO call bottom error
    }
  }

  Future<void> joinFamily(String familyId) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Families>(context, listen: false)
          .joinFamily(widget.userId, familyId);
      await Provider.of<Families>(context, listen: false)
          .fetchAndSetFamily(widget.userId);
      _index += 1;
      // Provider.of<Families>(context, listen: false).setCurrentFamily(_index);
      await getAllData();
      // TODO call bottom success
    } catch (e) {
      print(e);
      // setState(() {
      //   _isLoading = false;
      // });
      // TODO call bottom error
    }
  }

  Future<void> changeFamily(int index) async {
    _index = index;
    Provider.of<Families>(context, listen: false).setCurrentFamily(_index);
    await getAllData();
  }

  Future<void> getAllData() async {
    print('fetching');
    setState(() {
      _isLoading = true;
    });
    _familyIds = Provider.of<Families>(context, listen: false).families;
    _index = Provider.of<Families>(context, listen: false).currentFamilyIndex;
    print(_familyIds[_index]);
    final url = Uri.parse(
      '$api_url/all/${_familyIds[_index]}',
    );

    try {
      final res = await http.get(
        url,
      );

      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      print('data:' + extractedData['data'].toString());
      // TODO: Here
      // * set every thing
      // set fridge item

      // set recipe

      // set shopping list

      // * ------------------
      _familyName = extractedData['data']['family_name'];
      setState(() {
        _isLoading = false;
        _isInit = true;
      });
    } catch (e) {
      print('err: $e');
      setState(() {
        _isLoading = false;
        _isInit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.green,
        ),
        child: HomeDrawer(addNewFridchen, joinFamily),
      ),
      backgroundColor: AppColors.lightGreen,
      body: (_isLoading && !_isInit)
          ? SplashScreen()
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                // width: double.infinity,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  children: [
                    Container(
                      // flex: 2,
                      height: 160,
                      child: FamilySelect(
                        currentIndex: _index,
                        familyLength: _familyIds.length,
                        changeFamily: changeFamily,
                        addNewFridchen: addNewFridchen,
                        familyId: _familyIds[_index],
                        familyName: _familyName,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Menu(_isLoading),
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
            ),
    );
  }
}

class FamilySelect extends StatelessWidget {
  final int currentIndex;
  final int familyLength;
  final String familyId;
  final Function(int) changeFamily;
  final Function(String) addNewFridchen;
  final String familyName;

  const FamilySelect({
    required this.currentIndex,
    required this.familyLength,
    required this.changeFamily,
    required this.addNewFridchen,
    required this.familyId,
    required this.familyName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final fridchenFamily = Provider.of<Families>(context);

    void _addNewFridchenDialog() {
      showDialog(
        context: context,
        builder: (_) => DialogNewFridchen(addNewFridchen),
      );
    }

    void _changeFamily(int num) {
      if (num == -1 && currentIndex == 0) return;
      changeFamily(currentIndex + num);
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
                  currentIndex > 0
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          padding: EdgeInsets.only(
                            bottom: 4,
                          ),
                          splashRadius: 35,
                          iconSize: 45,
                          color: AppColors.darkGreen,
                          onPressed: () {
                            _changeFamily(-1);
                          },
                        )
                      : SizedBox(width: 45),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: FittedBox(
                      child: Text(
                        familyName,
                        textScaleFactor: 1,
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
                          builder: (context) => AddMemberScreen(familyId),
                        ),
                      );
                    },
                  ),
                  currentIndex == familyLength - 1
                      ? IconButton(
                          icon: const Icon(Icons.add_rounded),
                          padding: EdgeInsets.only(
                            bottom: 8,
                          ),
                          splashRadius: 35,
                          iconSize: 60,
                          color: AppColors.darkGreen,
                          onPressed: _addNewFridchenDialog,
                        )
                      : IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          padding: EdgeInsets.only(
                            bottom: 4,
                          ),
                          splashRadius: 35,
                          iconSize: 45,
                          color: AppColors.darkGreen,
                          onPressed: () {
                            _changeFamily(1);
                          },
                        ),
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
  final bool isLoading;
  const Menu(this.isLoading);

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
          return isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow,
                  ),
                )
              : Row(
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
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ListScreen(),
                          ),
                        );
                      },
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
