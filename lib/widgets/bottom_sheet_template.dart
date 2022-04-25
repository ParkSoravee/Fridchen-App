import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/custom_button.dart';

class BottomSheetTemplate extends StatelessWidget {
  final Color background;
  final String title;
  final Widget child;
  final Function() submitForm;
  final bool isShort;

  const BottomSheetTemplate({
    Key? key,
    required this.background,
    required this.title,
    required this.child,
    required this.submitForm,
    this.isShort = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom < 30;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 35,
      ),
      height: isShort
          ? MediaQuery.of(context).size.height / 1.9
          : MediaQuery.of(context).size.height - 150,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 77,
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 52,
              bottom: 5,
            ),
            child: FittedBox(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColors.white,
                  // fontSize: 60,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: child,
            ),
          ),
          // if (MediaQuery.of(context).viewInsets.bottom < 30)
          Container(
            // color: Colors.amber,
            padding: EdgeInsets.only(
              top: isKeyboard ? 25 : 20,
              bottom: isKeyboard ? 40 : 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  text: 'Cancel',
                  primaryColor: AppColors.darkGreen,
                  secondaryColor: background,
                  isPrimary: false,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CustomButton(
                  text: 'Confirm',
                  primaryColor: AppColors.darkGreen,
                  secondaryColor: background,
                  isPrimary: true,
                  onPressed: submitForm,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
