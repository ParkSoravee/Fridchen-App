import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/material.dart';
import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';

class ShareMenuScreen extends StatefulWidget {
  final String menuId;
  const ShareMenuScreen(this.menuId);

  @override
  State<ShareMenuScreen> createState() => _ShareMenuScreenState();
}

class _ShareMenuScreenState extends State<ShareMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
        title: 'Share',
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
                    data: widget.menuId,
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
                      text: "SENT THIS TO SHARE\n",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontFamily: "BebasNeue",
                      ),
                    ),
                    TextSpan(
                      text: "YOUR RECIPE",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontFamily: "BebasNeue",
                      ),
                    ),
                  ])),
                ),
              )
            ],
          ),
        ));
  }
}
