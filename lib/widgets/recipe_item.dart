import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fridchen_app/providers/recipes.dart';
import 'package:fridchen_app/widgets/tag_list.dart';

import '../themes/color.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe item;
  RecipeListItem({Key? key, required this.item}) : super(key: key);

  final List<Widget> dismissBackground = [
    SlidableAction(
      onPressed: (ctx) {},
      backgroundColor: AppColors.yellow,
      foregroundColor: AppColors.darkGreen,
      icon: Icons.push_pin_rounded,
    ),
    SlidableAction(
      onPressed: (ctx) {},
      backgroundColor: AppColors.lightGreen,
      foregroundColor: AppColors.darkGreen,
      icon: Icons.edit,
    ),
    SlidableAction(
      onPressed: (ctx) {},
      backgroundColor: AppColors.red,
      foregroundColor: AppColors.darkGreen,
      icon: CupertinoIcons.delete_solid,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
      // decoration: BoxDecoration(
      //   color: AppColors.red,
      // ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(
          //   onDismissed: () {}, // TODO
          // ),
          // extentRatio: 0.4,
          children: dismissBackground,
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
                          item.name,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 26,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        if (item.isPin)
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
                    child: TagList(tags: item.tags),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
