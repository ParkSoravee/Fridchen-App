import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/api.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:fridchen_app/screens/home_screen.dart';
import 'package:fridchen_app/screens/qrcode/join_family_screen.dart';
import 'package:fridchen_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../socket.dart';
import '../themes/color.dart';
import '../widgets/dialog_confirm.dart';
import '../widgets/row_with_title.dart';

class FetchFamilyScreen extends StatefulWidget {
  final String userId;

  const FetchFamilyScreen(this.userId);

  @override
  State<FetchFamilyScreen> createState() => _FetchFamilyScreenState();
}

class _FetchFamilyScreenState extends State<FetchFamilyScreen> {
  List<String> familyIds = [];

  Future<void> fetchAndSetFamily() async {
    familyIds = await Provider.of<Families>(context, listen: false)
        .fetchAndSetFamily(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Families>(
        builder: (context, family, _) => FutureBuilder(
          future: fetchAndSetFamily(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? SplashScreen()
                  : familyIds.isNotEmpty
                      ? FutureBuilder<Socket>(
                          future: MySocket.initSocket(context),
                          builder: (ctx, snap) {
                            if (snap.hasData) {
                              return MyHomePage(
                                familyIds,
                                widget.userId,
                                snap.data!,
                              );
                            } else {
                              return SplashScreen();
                            }
                          },
                        )
                      : NewFridchenScreen(widget.userId),
          // ? MyHomePage(familyIds, widget.userId)
          // : familyIds.isEmpty
          //     ? NewFridchenScreen(widget.userId)
          //     : MyHomePage(familyIds, widget.userId),
        ),
      ),
    );
  }
}

class NewFridchenScreen extends StatefulWidget {
  final String userId;

  const NewFridchenScreen(this.userId);

  @override
  State<NewFridchenScreen> createState() => _NewFridchenScreenState();
}

class _NewFridchenScreenState extends State<NewFridchenScreen> {
  final _form = GlobalKey<FormFieldState>();
  String fridchenName = '';

  void callQrJoin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JoinFamilyScreen(joinFamily),
      ),
    );
  }

  Future<void> joinFamily(String familyId) async {
    try {
      await Provider.of<Families>(context, listen: false)
          .joinFamily(widget.userId, familyId);

      // TODO call bottom success
    } catch (e) {
      print(e);
      // TODO call bottom error
    }
  }

  Future<void> addNewFridchen() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();

    try {
      Provider.of<Families>(context, listen: false)
          .newFamily(widget.userId, fridchenName, first: true);
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
        backgroundColor: AppColors.darkGreen,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkGreen,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 60,
            ),
            alignment: Alignment.topCenter,
            child: Text(
              'WELCOME\nTO FRIDCHEN!',
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
              style: TextStyle(
                color: AppColors.yellow,
                fontSize: 64,
                // height: 1.2,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: Text(
                      'Join Fridchen',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    print('joining...');
                    callQrJoin();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.darkGreen,
                    side: BorderSide(color: AppColors.yellow, width: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        height: 5,
                        width: 95,
                        decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Text(
                        'OR',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: AppColors.yellow,
                          fontSize: 32,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 5,
                        width: 95,
                        decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: Text(
                      'New Fridchen',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        color: AppColors.darkGreen,
                        fontSize: 40,
                        height: 1.2,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    addNewFridchenDialog();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    // side: BorderSide(color: AppColors.yellow, width: 6),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
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
