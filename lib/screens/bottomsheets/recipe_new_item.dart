import 'package:flutter/material.dart';
import 'package:fridchen_app/screens/qrcode/share_menu_screen.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/bottom_sheet_template.dart';
import 'package:fridchen_app/widgets/dialog_recipe_new_ingredient.dart';
import 'package:fridchen_app/widgets/dialog_recipe_new_step.dart';
import 'package:fridchen_app/widgets/ingredient_step_list_item.dart';
import 'package:fridchen_app/widgets/row_with_title.dart';
import 'package:provider/provider.dart';

import '../../providers/api.dart';
import '../../providers/family.dart';
import '../../providers/recipes.dart';
import '../../providers/tags.dart';
import '../../providers/unit.dart';
import '../../widgets/dialog_alert.dart';
import '../../widgets/tag_select.dart';

class RecipeNewItem extends StatefulWidget {
  final Recipe? item;
  final bool onEdit;

  const RecipeNewItem({
    Key? key,
    this.item,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<RecipeNewItem> createState() => _RecipeNewItemState();
}

class _RecipeNewItemState extends State<RecipeNewItem> {
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool isValid = true;

  final primaryColor = AppColors.yellow;
  final secondaryColor = AppColors.orange;

  String? _name;
  List<String> _tagsId = [];
  List<Ingredient> _ingredients = [];
  List<String> _steps = [];

  void setSelectedTags(String tagId) {
    final result =
        _tagsId.firstWhere((element) => element == tagId, orElse: () => '');
    if (result == '') {
      _tagsId.add(tagId);
    } else {
      _tagsId.remove(tagId);
    }
  }

  Future<void> submitForm() async {
    print('submit');
    isValid = _ingredients.length > 0 && _steps.length > 0;
    isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState!.save();

    final item = Recipe(
      name: _name!,
      ingredients: _ingredients,
      steps: _steps,
      tagIds: _tagsId,
    );

    try {
      final familyId =
          Provider.of<Families>(context, listen: false).currentFamilyId;
      if (widget.item != null) {
        if (widget.onEdit) {
          // edit

          final itemUpdate = Recipe(
            id: widget.item!.id,
            name: _name!,
            ingredients: _ingredients,
            steps: _steps,
            tagIds: _tagsId,
          );
          await Provider.of<Api>(context, listen: false)
              .updateRecipeItem(itemUpdate);
        }
      } else {
        // new
        await Provider.of<Api>(context, listen: false)
            .addRecipeItem(familyId, item);
      }

      Navigator.pop(context);
      // TODO: show success
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (ctx) => DialogAlert(
          title: 'Please connect the internet.',
          smallTitle: true,
          primaryColor: AppColors.white,
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  Future<void> cook() async {
    try {
      final familyId =
          Provider.of<Families>(context, listen: false).currentFamilyId;
      await Provider.of<Api>(context, listen: false)
          .cookRecipeItem(familyId, widget.item!);

      Navigator.pop(context);
      // TODO: show success
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (ctx) => DialogAlert(
          title: 'Please connect the internet.',
          smallTitle: true,
          primaryColor: AppColors.white,
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  void shareMenu() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShareMenuScreen(widget.item!.id!),
      ),
    );
  }

  Future<void> addNewIngredient() async {
    await showDialog(
      context: context,
      builder: (_) => DialogRecipeNewIngredient(
        setIngredient: (ing) {
          setState(() {
            _ingredients.add(ing);
          });
        },
      ),
    );
  }

  Future<void> addNewStep() async {
    await showDialog(
      context: context,
      builder: (_) => DialogRecipeNewStep(
        setStep: (step) {
          setState(() {
            _steps.add(step);
          });
        },
      ),
    );
  }

  void deleteIngredient(int i) {
    setState(() {
      _ingredients.removeAt(i);
    });
  }

  void deleteStep(int i) {
    setState(() {
      _steps.removeAt(i);
    });
  }

  @override
  void initState() {
    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _ingredients = [...widget.item!.ingredients];
      _steps = [...widget.item!.steps];
      _tagsId = widget.item!.tagIds;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTemplate(
      showQr: (widget.item == null || widget.onEdit) ? null : shareMenu,
      title: (widget.item == null || widget.onEdit)
          ? widget.onEdit
              ? 'Edit recipe'
              : 'New Recipe'
          : widget.item!.name,
      background: primaryColor,
      submitForm: widget.item != null && !widget.onEdit ? cook : submitForm,
      confirmText: widget.item != null && !widget.onEdit ? 'Cook!' : 'Confirm',
      cancelText: widget.item != null && !widget.onEdit ? 'Back' : 'Cancel',
      child: Form(
        key: _form,
        child: Column(
          children: [
            if (widget.item == null || widget.onEdit)
              RowWithTitle(
                title: 'Name : ',
                child: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: InputBorder.none,
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                      ),
                      cursorColor: secondaryColor,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 36,
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) async {
                        // FocusScope.of(context).requestFocus(_volumnFocusNode);
                        // await setExpDate();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name.';
                        }

                        if (value.length > 30) {
                          return 'Name can be only 1-30 characters.';
                        }

                        // if (value.contains(special)) {
                        //   return 'Name can have only 1-25 characters';
                        // }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value;
                      },
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 3,
            ),
            RowWithTitle(
              title: 'Ingredients : ',
              child: [
                if (widget.item == null || widget.onEdit)
                  GestureDetector(
                    onTap: addNewIngredient,
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.white,
                      ),
                      padding: EdgeInsets.fromLTRB(4, 6, 10, 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_rounded,
                            // size: 32,
                            color: primaryColor,
                          ),
                          Text(
                            'New Ingredient',
                            style: TextStyle(
                              fontSize: 19,
                              color: primaryColor,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            ingredientsList(),
            if (!isValid && _ingredients.isEmpty)
              Container(
                padding: EdgeInsets.only(top: 3),
                width: double.infinity,
                child: Text(
                  'Invalid ingredients.',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            SizedBox(
              height: 8,
            ),
            RowWithTitle(
              title: 'Steps : ',
              child: [
                if (widget.item == null || widget.onEdit)
                  GestureDetector(
                    onTap: addNewStep,
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.white,
                      ),
                      padding: EdgeInsets.fromLTRB(4, 6, 10, 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_rounded,
                            // size: 32,
                            color: primaryColor,
                          ),
                          Text(
                            'New Step',
                            style: TextStyle(
                              fontSize: 19,
                              color: primaryColor,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            stepList(),
            if (!isValid && _steps.isEmpty)
              Container(
                padding: EdgeInsets.only(top: 3),
                width: double.infinity,
                child: Text(
                  'Invalid step descriptions.',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            if (widget.item == null || widget.onEdit)
              SizedBox(
                height: 10,
              ),
            if (widget.item == null || widget.onEdit)
              RowWithTitle(
                title: 'TAG : ',
                isAlignStart: true,
                child: [
                  TagSelect(
                    tags: Provider.of<Tags>(context, listen: false).defaultTags,
                    setSelectedTags: setSelectedTags,
                    selectedTagsId: _tagsId,
                  ),
                ],
              ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Container stepList() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      height: 180,
      color: Color(0x0A000000),
      child: ListView.builder(
        itemCount: _steps.length,
        itemBuilder: (ctx, i) => IngredientStepListItem(
          name: '${i + 1}. ' + _steps[i],
          index: i,
          onDelete: (widget.item == null || widget.onEdit) ? deleteStep : null,
        ),
      ),
    );
  }

  Container ingredientsList() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      height: 140,
      color: Color(0x0A000000),
      child: ListView.builder(
        itemCount: _ingredients.length,
        itemBuilder: (ctx, i) => IngredientStepListItem(
          name: _ingredients[i].name,
          index: i,
          amount:
              '${_ingredients[i].amount} ${Provider.of<Units>(context, listen: false).getNameById(_ingredients[i].unitId)}',
          onDelete:
              (widget.item == null || widget.onEdit) ? deleteIngredient : null,
        ),
      ),
    );
  }
}
