import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';

class JoinFamilyScreen extends StatefulWidget {
  final Function(String) setValue;
  const JoinFamilyScreen(this.setValue);

  @override
  State<JoinFamilyScreen> createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends State<JoinFamilyScreen> {
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
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.darkGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: buildQrView(context),
              ),
            ),
            Expanded(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: " PLEASE LOGIN BEFORE\n",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: "BebasNeue",
                        ),
                      ),
                      TextSpan(
                        text: "JOIN FAMILY BY QR CODE",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: "BebasNeue",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
          borderColor: AppColors.green,
          borderRadius: 10,
          borderWidth: 10,
          borderLength: 20,
          // cutOutSize: MediaQuery.of(context).size.width * 1,
          cutOutSize: MediaQuery.of(context).size.width,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen(
      (barcode) => setState(
        () {
          this.barcode = barcode;
          print(barcode.code);
          widget.setValue(barcode.code!);
          controller.pauseCamera();
          Navigator.pop(context);
        },
      ),
    );
  }
}
