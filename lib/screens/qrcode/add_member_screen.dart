import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/material.dart';
import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  bool qrcode_show = false;
  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
        title: 'ADD',
        primaryColor: AppColors.orange,
        secondaryColor: AppColors.green,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              qrcode_show
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: QrImage(
                        data: 'data in put',
                        version: QrVersions.auto,
                        errorStateBuilder: (cxt, err) {
                          return Container(
                            child: Center(
                                child: Text("Something went wrong...",
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: AppColors.darkGreen,
                                    ))),
                          );
                        },
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: IconButton(
                          icon: const Icon(Icons.qr_code_scanner_outlined),
                          iconSize: 150,
                          color: Colors.black.withOpacity(0.65),
                          onPressed: () {
                            setState(() {
                              qrcode_show = true;
                            });
                          }),
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
                            fontFamily: "BebasNeue")),
                    TextSpan(
                        text: "            FAMILY",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontFamily: "BebasNeue")),
                  ])),
                ),
              )
            ],
          ),
        ));
  }
}
