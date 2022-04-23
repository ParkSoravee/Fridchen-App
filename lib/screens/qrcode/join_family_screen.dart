import 'package:fridchen_app/screens/qrcode/sacnner_qr.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:flutter/material.dart';
import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  bool scanner_show = false;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
        title: 'JOIN',
        primaryColor: AppColors.lightGreen,
        secondaryColor: AppColors.green,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              scanner_show
                  ? Container(
                      child: Column(children: [buildQrView(context)]),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          iconSize: 150,
                          color: Colors.black.withOpacity(0.65),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => scanner_qr(),
                              ),
                            );
                          }),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: " PLEASE LOGIN BEFORE\n",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontFamily: "BebasNeue")),
                    TextSpan(
                        text: "JOIN FAMILY BY QR CODE",
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

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
  }
}
