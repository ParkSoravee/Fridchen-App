import 'package:fridchen_app/screens/qrcode/sacnner_qr.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';

import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
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
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.darkGreen),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: buildQrView(context),
                ),
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

//ไว้เทสอ่านqr code
  Widget buildResult() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(8)),
        child: Text(
          barcode != null ? 'Result : ${barcode!.code}' : 'Scan a code!',
          maxLines: 3,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontFamily: "BebasNeue"),
        ),
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: AppColors.red,
            borderRadius: 10,
            borderWidth: 10,
            borderLength: 20,
            cutOutSize: MediaQuery.of(context).size.width * 1),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }
}
