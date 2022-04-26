import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/qrcode/join_family_screen.dart';
import '../themes/color.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool _lights = false;

  Future<void> logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.darkGreen,
                      backgroundImage: NetworkImage(
                        user.img!,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        // user.name ?? 'USER',
                        'Park Soravee',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.yellow, fontSize: 24),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'HOME',
                          style: TextStyle(color: Colors.white, fontSize: 36),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Fridchen',
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 36,
                      ),
                    ),
                    Divider(
                      color: AppColors.darkGreen,
                      height: 0,
                      thickness: 3,
                    ),
                    TextButton(
                      child: Text(
                        'JOIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      child: Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: BorderSide(
                          color: AppColors.darkGreen,
                          width: 3,
                        ),
                      ),
                      child: Text(
                        'LEAVE FAMILY',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.darkGreen,
                          fontFamily: "BebasNeue",
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Divider(
                      color: AppColors.darkGreen,
                      height: 10,
                      thickness: 3,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: Text(
                              'DARK MODE',
                              style: TextStyle(
                                // fontSize: 20,
                                color: AppColors.darkGreen,
                                fontFamily: "BebasNeue",
                              ),
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: _lights,
                            activeColor: Colors.white,
                            // activeTrackColor: AppColors.darkGreen,
                            // inactiveThumbColor: AppColors.darkGreen,
                            // inactiveTrackColor: Colors.white,
                            thumbColor: AppColors.darkGreen,
                            trackColor: AppColors.white,
                            onChanged: (bool value) {
                              setState(() {
                                _lights = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    OutlinedButton(
                      child: Text(
                        'LOG OUT',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.green,
                          fontFamily: "BebasNeue",
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.darkGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: logout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
