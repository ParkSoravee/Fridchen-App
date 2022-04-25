import 'package:flutter/material.dart';
import 'package:fridchen_app/widgets/custom_button.dart';

class DialogAlert extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final Color backgroundColor;
  final Widget? content;
  final bool isCenterTitle;
  final bool smallTitle;

  const DialogAlert({
    required this.title,
    required this.primaryColor,
    required this.backgroundColor,
    this.content,
    this.isCenterTitle = false,
    this.smallTitle = false,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: smallTitle ? 30 : 45, //TODO: when long text
          color: primaryColor,
        ),
        textAlign: isCenterTitle ? TextAlign.center : null,
      ),
      content: content == null
          ? null
          : Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: content,
            ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              isPrimary: false,
              downsize: 5,
              primaryColor: primaryColor,
              secondaryColor: backgroundColor,
              text: 'Okay',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
