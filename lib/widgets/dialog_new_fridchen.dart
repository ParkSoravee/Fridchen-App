import 'package:flutter/material.dart';
import 'package:fridchen_app/widgets/row_with_title.dart';

import '../themes/color.dart';
import 'dialog_confirm.dart';

class DialogNewFridchen extends StatefulWidget {
  final Function(String) addNewFridge;
  const DialogNewFridchen(this.addNewFridge);

  @override
  State<DialogNewFridchen> createState() => _DialogNewFridchenState();
}

class _DialogNewFridchenState extends State<DialogNewFridchen> {
  final _form = GlobalKey<FormFieldState>();
  String fridchenName = '';

  void formSubmit() {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
    widget.addNewFridge(fridchenName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DialogConfirm(
      title: 'New fridchen',
      primaryColor: AppColors.yellow,
      backgroundColor: AppColors.darkGreen,
      confirm: formSubmit,
      content: RowWithTitle(
        title: 'NAME :',
        isAlignStart: true,
        color: AppColors.white,
        child: [
          Expanded(
            child: TextFormField(
              key: _form,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                filled: true,
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 2),
                hintText: 'Apartment',
                hintStyle: TextStyle(
                  color: AppColors.white.withOpacity(0.2),
                  fontSize: 36,
                ),
              ),
              cursorColor: AppColors.yellow,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 36,
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                formSubmit();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter fridchen name.';
                }

                if (value.length > 12) {
                  return 'Name can be only 1-12 characters.';
                }
                return null;
              },
              onSaved: (value) {
                fridchenName = value!.trim();
              },
            ),
          ),
        ],
      ),
    );
  }
}
