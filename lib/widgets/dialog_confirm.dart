import 'package:flutter/material.dart';

class Popup_confirm extends StatelessWidget {
  final String texttitle;
  final Color primaryColor;
  final Color secondaryColor;
  final Color titletextColor;
  final Widget child;

  const Popup_confirm({
    required this.texttitle,
    required this.primaryColor,
    required this.secondaryColor,
    required this.titletextColor,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        texttitle,
        style: TextStyle(
            fontSize: 50, color: titletextColor, fontFamily: "BebasNeue"),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: child,
          )
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 5,
                      color: secondaryColor,
                    ),
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 20,
                        color: secondaryColor,
                        //fontWeight: FontWeight.bold,
                        fontFamily: "BebasNeue"),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        //fontWeight: FontWeight.bold,
                        fontFamily: "BebasNeue"),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
