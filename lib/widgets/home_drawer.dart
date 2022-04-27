import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../providers/auth.dart';
import '../screens/qrcode/join_family_screen.dart';
import '../themes/color.dart';
import 'dialog_new_fridchen.dart';

class HomeDrawer extends StatefulWidget {
  final Function(String) addNewFridchen;
  final Function(String) joinFamily;
  final Socket socket;

  const HomeDrawer(this.addNewFridchen, this.joinFamily, this.socket);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool _lights = false;

  Future<void> _logout() async {
    await Provider.of<Auth>(context, listen: false).logout();
  }

  Future<void> _leaveFamily() async {
    final userId = Provider.of<Auth>(context, listen: false).userId!;
    await Provider.of<Families>(context, listen: false).leaveFamily(userId);
    widget.socket.disconnect();
    widget.socket.connect();
  }

  void _joinFamily() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JoinFamilyScreen(widget.joinFamily),
      ),
    );
  }

  void _addNewFridchenDialog() {
    showDialog(
      context: context,
      builder: (_) => DialogNewFridchen(widget.addNewFridchen),
    );
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
                      backgroundImage: user.img == null
                          ? null
                          : NetworkImage(
                              user.img!,
                            ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        user.name ?? 'USER',
                        // 'Park Soravee',
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
                      onPressed: _joinFamily,
                    ),
                    TextButton(
                      child: Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                      onPressed: _addNewFridchenDialog,
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
                      onPressed: _leaveFamily,
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
                      onPressed: _logout,
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
