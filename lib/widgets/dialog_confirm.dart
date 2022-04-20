import 'package:flutter/material.dart';
import 'package:fridchen_app/widgets/custom_button.dart';

class DialogConfirm extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final Color secondaryColor;
  final Widget? content;
  final Function() confirm;

  const DialogConfirm({
    required this.title,
    required this.primaryColor,
    required this.secondaryColor,
    required this.confirm,
    this.content,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 45, //TODO: when long text
          color: primaryColor,
        ),
        textAlign: content == null ? TextAlign.center : null,
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
              isPrimary: true,
              isBorder: true,
              downsize: 5,
              primaryColor: primaryColor,
              text: 'Cancel',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CustomButton(
              isPrimary: false,
              isBorder: true,
              downsize: 5,
              primaryColor: primaryColor,
              text: 'Confirm',
              onPressed: confirm,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
