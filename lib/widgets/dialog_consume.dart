import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/fridges.dart';

import '../themes/color.dart';
import 'dialog_confirm.dart';

class DialogConsume extends StatefulWidget {
  final FridgeItem item;
  final Function(double) isConfirm;
  const DialogConsume({
    Key? key,
    required this.item,
    required this.isConfirm,
  }) : super(key: key);

  @override
  State<DialogConsume> createState() => _DialogConsumeState();
}

class _DialogConsumeState extends State<DialogConsume> {
  final _form = GlobalKey<FormFieldState>();
  double amount = 0.0;

  void submitForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;

    _form.currentState!.save();
    widget.isConfirm(amount);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DialogConfirm(
      title: 'Consume:',
      primaryColor: AppColors.darkGreen,
      backgroundColor: AppColors.green,
      confirm: () {
        submitForm();
      },
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.item.name,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 35,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                child: TextFormField(
                  key: _form,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      color: AppColors.darkGreen.withOpacity(0.4),
                      // fontSize: 36,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    filled: true,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                  ),
                  cursorColor: AppColors.lightGreen,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 36,
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.parse(value) <= 0) {
                      return 'Please enter amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Invalid amount.';
                    }
                    if (double.parse(value) > 10000) {
                      return 'Invalid amount.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    amount = double.parse(value!);
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.item.unit.name,
                style: TextStyle(
                  color: AppColors.darkGreen,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
