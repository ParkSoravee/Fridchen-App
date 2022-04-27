import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fridchen_app/providers/recipes.dart';
import 'package:fridchen_app/screens/bottomsheets/recipe_new_item.dart';
import 'package:fridchen_app/widgets/tag_list.dart';
import 'package:provider/provider.dart';

import '../providers/api.dart';
import '../providers/family.dart';
import '../providers/tags.dart';
import '../themes/color.dart';
import 'dialog_confirm.dart';
import 'ingredient_step_list_item.dart';

class RecipeListItem extends StatefulWidget {
  final Recipe item;
  RecipeListItem({Key? key, required this.item}) : super(key: key);

  @override
  State<RecipeListItem> createState() => _RecipeListItemState();
}

class _RecipeListItemState extends State<RecipeListItem> {
  List<Widget> dismissBackground() {
    return [
      SlidableAction(
        onPressed: (ctx) {
          pinRecipe();
        },
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.darkGreen,
        icon: Icons.push_pin_rounded,
      ),
      SlidableAction(
        onPressed: (_) {
          editRecipe();
        },
        backgroundColor: AppColors.lightGreen,
        foregroundColor: AppColors.darkGreen,
        icon: Icons.edit,
      ),
      SlidableAction(
        onPressed: (ctx) {
          deleteRecipe();
        },
        backgroundColor: AppColors.red,
        foregroundColor: AppColors.darkGreen,
        icon: CupertinoIcons.delete_solid,
      )
    ];
  }

  void seeRecipe() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.darkGreen.withOpacity(0.70),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: RecipeNewItem(
          item: widget.item,
          onEdit: false,
        ),
      ),
    );
  }

  void editRecipe() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.darkGreen.withOpacity(0.70),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: RecipeNewItem(
          item: widget.item,
          onEdit: true,
        ),
      ),
    );
  }

  Future<void> pinRecipe() async {
    bool isConfirm = false;
    await showDialog(
      context: context,
      builder: (_) => DialogConfirm(
        isCenterTitle: true,
        smallTitle: true,
        title: 'Are you sure to pin this?',
        primaryColor: AppColors.darkGreen,
        backgroundColor: AppColors.yellow,
        confirm: () {
          isConfirm = true;
          Navigator.pop(context);
        },
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item.name,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'ingredients below will be added\nto your shopping list.',
              style: TextStyle(
                color: AppColors.darkGreen,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              // color: Colors.red,
              width: double.infinity,
              child: ListView.builder(
                itemCount: widget.item.ingredients.length,
                itemBuilder: (ctx, i) => IngredientStepListItem(
                  name: widget.item.ingredients[i].name,
                  index: i,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (!isConfirm) return;
    try {
      final familyId =
          Provider.of<Families>(context, listen: false).currentFamilyId;
      await Provider.of<Api>(context, listen: false)
          .pinRecipeItem(familyId, widget.item);
      // TODO: bottom success
    } catch (e) {
      // TODO: bottom error
    }
  }

  Future<void> deleteRecipe() async {
    bool isConfirm = false;
    await showDialog(
      context: context,
      builder: (_) => DialogConfirm(
        isCenterTitle: true,
        // smallTitle: true,
        title: 'Are you sure?',
        primaryColor: AppColors.darkGreen,
        backgroundColor: AppColors.yellow,
        confirm: () {
          isConfirm = true;
          Navigator.pop(context);
        },
      ),
    );

    if (!isConfirm) return;
    try {
      final familyId =
          Provider.of<Families>(context, listen: false).currentFamilyId;
      await Provider.of<Api>(context, listen: false)
          .deleteRecipeItem(familyId, widget.item);
      // TODO: bottom success
    } catch (e) {
      // TODO: bottom error
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: seeRecipe,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            // dismissible: DismissiblePane(
            //   onDismissed: () {}, // TODO
            // ),
            // extentRatio: 0.4,
            children: dismissBackground(),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              color: AppColors.darkGreen,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            widget.item.name,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 26,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          if (widget.item.isPin)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Icon(
                                Icons.push_pin_rounded,
                                color: AppColors.white,
                                size: 26,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.orange,
                  height: 6,
                  thickness: 2.5,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TagList(
                        tags: Provider.of<Tags>(context, listen: false)
                            .getTagsById(widget.item.tagIds),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
