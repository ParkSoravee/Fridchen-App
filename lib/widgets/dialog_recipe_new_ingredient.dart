import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/recipes.dart';
import 'package:fridchen_app/widgets/row_with_title.dart';

import '../providers/unit.dart';
import '../themes/color.dart';
import 'dialog_confirm.dart';

class DialogRecipeNewIngredient extends StatefulWidget {
  final Function(Ingredient) setIngredient;

  const DialogRecipeNewIngredient({
    Key? key,
    required this.setIngredient,
  }) : super(key: key);

  @override
  State<DialogRecipeNewIngredient> createState() =>
      _DialogRecipeNewIngredientState();
}

class _DialogRecipeNewIngredientState extends State<DialogRecipeNewIngredient> {
  final _form = GlobalKey<FormState>();
  final _amountFocusNode = FocusNode();

  String? _name;
  double? _amount;
  String? _selectedUnit;

  void submitForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;

    _form.currentState!.save();
    final ing = Ingredient(
      name: _name!,
      amount: _amount!,
      unit: _selectedUnit!,
    );
    widget.setIngredient(ing);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DialogConfirm(
      title: 'New ingredient',
      primaryColor: AppColors.orange,
      backgroundColor: AppColors.darkGreen,
      confirm: () {
        submitForm();
      },
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RowWithTitle(
              title: 'Name : ',
              color: AppColors.orange,
              child: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      fillColor: AppColors.white.withOpacity(0.1),
                      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                    ),
                    cursorColor: AppColors.lightGreen,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) async {
                      FocusScope.of(context).requestFocus(_amountFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter item name.';
                      }

                      if (value.length > 25) {
                        return 'Name can be only 1-25 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!.trim();
                    },
                  ),
                ),
              ],
            ),
            RowWithTitle(
              title: 'Amount : ',
              color: AppColors.orange,
              child: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      fillColor: AppColors.white.withOpacity(0.1),
                      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                    ),
                    cursorColor: AppColors.lightGreen,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter item amount or volume.';
                      }

                      if (double.tryParse(value) == null) {
                        return 'Invalid volume.';
                      }

                      if (double.parse(value) > 10000) {
                        return 'Invalid volume.';
                      }

                      if (_selectedUnit == null) {
                        return 'Invalid unit.';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _amount = double.parse(value!);
                    },
                  ),
                ),
              ],
            ),
            RowWithTitle(
              title: 'Unit : ',
              color: AppColors.orange,
              child: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectedUnit,
                    menuMaxHeight: 220,
                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                    hint: Text(
                      'Select unit',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 30,
                      ),
                    ),
                    dropdownColor: AppColors.orange,
                    items: Units().getDropdownMenuItem(30, AppColors.white),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnit = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
