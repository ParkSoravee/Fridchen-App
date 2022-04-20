import 'package:flutter/material.dart';

import '../screens/qrcode/join_family_screen.dart';
import '../themes/color.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool _lights = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          children: [
            Container(
              margin: EdgeInsets.all(15),
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Center(
              child: Text(
                'USER',
                style: TextStyle(color: AppColors.yellow, fontSize: 26),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: TextButton(
              child: Text(
                'HOME',
                style: TextStyle(color: Colors.white, fontSize: 36),
              ),
              onPressed: () {},
            )),
            SizedBox(
              height: 40,
            ),
            Stack(children: [
              Center(
                child: Text(
                  'FAMILY',
                  style: TextStyle(
                    color: AppColors.darkGreen,
                    fontSize: 36,
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 27,
                child: Container(
                  height: 4,
                  width: 140,
                  color: AppColors.darkGreen,
                ),
              ),
            ]),
            Center(
                child: TextButton(
              child: Text(
                'NEW',
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              onPressed: () {},
            )),
            Center(
                child: TextButton(
              child: Text(
                'JOIN',
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              onPressed: () {},
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 43,
                width: 140,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: AppColors.darkGreen,
                    ),
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(25)),
                child: TextButton(
                  child: Text(
                    'LEAVE FAMILY',
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.darkGreen,
                        fontFamily: "BebasNeue"),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                height: 4,
                width: 140,
                color: AppColors.darkGreen,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SwitchListTile(
                title: const Text(
                  'DARK MODE',
                  style: TextStyle(
                      fontSize: 22,
                      color: AppColors.darkGreen,
                      fontFamily: "BebasNeue"),
                ),
                value: _lights,
                activeColor: Colors.white,
                activeTrackColor: AppColors.darkGreen,
                inactiveThumbColor: AppColors.darkGreen,
                inactiveTrackColor: Colors.white,
                onChanged: (bool value) {
                  setState(() {
                    _lights = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                    color: AppColors.darkGreen,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  child: Text(
                    'LOG OUT',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.green,
                        //fontWeight: FontWeight.bold,
                        fontFamily: "BebasNeue"),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
