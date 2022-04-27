import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/material.dart';
import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';

class AddMemberScreen extends StatefulWidget {
  final String familyId;
  const AddMemberScreen(this.familyId);

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
        title: 'ADD',
        primaryColor: AppColors.orange,
        secondaryColor: AppColors.green,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: QrImage(
                    data: widget.familyId,
                    version: QrVersions.auto,
                    errorStateBuilder: (cxt, err) {
                      return Container(
                        child: Center(
                          child: Text(
                            "Something went wrong...",
                            style: TextStyle(
                              fontSize: 35,
                              color: AppColors.darkGreen,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "SENT FOR ADDED TO\n",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: "BebasNeue"),
                    ),
                    TextSpan(
                      text: "            FAMILY",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: "BebasNeue"),
                    ),
                  ])),
                ),
              )
            ],
          ),
        ));
  }
}
