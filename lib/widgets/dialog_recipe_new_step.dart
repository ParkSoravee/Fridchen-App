import 'package:flutter/material.dart';
import 'package:fridchen_app/widgets/row_with_title.dart';

import '../themes/color.dart';
import 'dialog_confirm.dart';

class DialogRecipeNewStep extends StatefulWidget {
  final Function(String) setStep;

  const DialogRecipeNewStep({
    Key? key,
    required this.setStep,
  }) : super(key: key);

  @override
  State<DialogRecipeNewStep> createState() => _DialogRecipeNewStepState();
}

class _DialogRecipeNewStepState extends State<DialogRecipeNewStep> {
  final _form = GlobalKey<FormFieldState>();

  String? _text;

  int _textCount = 0;

  void submitForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;

    _form.currentState!.save();
    widget.setStep(_text!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DialogConfirm(
      title: 'New Step',
      primaryColor: AppColors.orange,
      backgroundColor: AppColors.darkGreen,
      confirm: () {
        submitForm();
      },
      content: Container(
        width: double.infinity,
        // height: 200,
        child: TextFormField(
          key: _form,
          decoration: InputDecoration(
            hintText: 'Add some love <3',
            hintStyle: TextStyle(
              color: AppColors.white.withOpacity(0.5),
              fontSize: 36,
            ),
            counterText: '$_textCount/150',
            counterStyle: TextStyle(
              color: AppColors.white.withOpacity(0.5),
              fontSize: 18,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: InputBorder.none,
            filled: true,
            // isDense: true,
            fillColor: AppColors.white.withOpacity(0.1),
            contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
          ),
          maxLines: 4,
          cursorColor: AppColors.lightGreen,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 36,
          ),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) {
            submitForm();
          },
          onChanged: (value) {
            setState(() {
              _textCount = value.length;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter step description.';
            }

            if (value.length > 150) {
              return 'Step description can be only 1-150 characters.';
            }
            return null;
          },
          onSaved: (value) {
            _text = value!.trim();
          },
        ),
      ),
    );
    ;
  }
}
