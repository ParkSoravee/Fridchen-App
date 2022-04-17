import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridchen_app/utils/date.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/tag_list.dart';
import 'package:provider/provider.dart';

class FridgeListItem extends StatefulWidget {
  final FridgeItem item;

  const FridgeListItem({Key? key, required this.item}) : super(key: key);

  @override
  State<FridgeListItem> createState() => _FridgeListItemState();
}

class _FridgeListItemState extends State<FridgeListItem> {
  Future<void> setExpDate() async {
    final date =
        await MyDateUtils.setExpDate(context: context, title: widget.item.name);
    if (date != null) {
      Provider.of<FridgeItems>(context, listen: false)
          .setExp(widget.item.id, date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.red,
      ), //TODO dismissible
      // child: Dismissible(
      //   key: ValueKey(widget.item.id),
      //   background: Container(
      //     decoration: BoxDecoration(
      //       color: AppColors.red,
      //     ),
      //     child: Icon(Icons.abc),
      //   ),
      //   secondaryBackground: Container(
      //     decoration: BoxDecoration(
      //       color: AppColors.green,
      //     ),
      //     child: Icon(Icons.abc),
      //   ),
      //   direction: DismissDirection.endToStart,
      child: Slidable(
        // key: ValueKey(widget.item.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(
          //   onDismissed: () {}, // TODO
          // ),
          extentRatio: 0.4,
          // extentRatio: 0.5,
          children: [
            DismissBackground(widget.item),
          ],
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
                        if (widget.item.isStar)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Icon(
                              Icons.star_rounded,
                              color: AppColors.yellow,
                              size: 26,
                            ),
                          ),
                      ],
                    ),
                  ),
                  widget.item.exp == null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                await setExpDate();
                              },
                              // radius: 50,
                              borderRadius: BorderRadius.circular(5),
                              child: Icon(
                                CupertinoIcons.calendar_badge_plus,
                                color: AppColors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          'EXP ${DateFormat('dd MMM yyyy').format(widget.item.exp!)}',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                          ),
                        )
                ],
              ),
              Divider(
                color: AppColors.lightGreen,
                height: 6,
                thickness: 2.5,
              ),
              Row(
                children: [
                  Expanded(
                    child: TagList(tags: widget.item.tags),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${(widget.item.countLeft % 1 == 0) ? widget.item.countLeft.toStringAsFixed(0) : widget.item.countLeft} ${widget.item.unit}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}

class DismissBackground extends StatelessWidget {
  final FridgeItem item;
  const DismissBackground(this.item);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // print('star');
                Provider.of<FridgeItems>(context, listen: false)
                    .setStar(item.id);
                Slidable.of(context)!.close();
              },
              child: Container(
                color: AppColors.yellow,
                height: double.infinity,
                width: double.infinity,
                child: Icon(
                  Icons.star_rounded,
                  color: AppColors.darkGreen,
                  size: 28,
                ),
              ),
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // TODO
                    print('add');
                    Slidable.of(context)!.close();
                  },
                  child: Container(
                    color: AppColors.lightGreen,
                    height: double.infinity,
                    width: double.infinity,
                    child: Icon(
                      CupertinoIcons.cart_fill_badge_plus,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // TODO
                    print('del');
                    Slidable.of(context)!.close();
                  },
                  child: Container(
                    color: AppColors.red,
                    height: double.infinity,
                    width: double.infinity,
                    child: Icon(
                      CupertinoIcons.delete_solid,
                      color: AppColors.darkGreen,
                      size: 24,
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
    // return SlidableAction(
    //   onPressed: (ctx) {},
    //   backgroundColor: AppColors.yellow,
    //   foregroundColor: AppColors.darkGreen,
    //   icon: Icons.star_rounded,
    // ),
    // SlidableAction(
    //   onPressed: (ctx) {},
    //   backgroundColor: AppColors.lightGreen,
    //   foregroundColor: AppColors.darkGreen,
    //   icon: CupertinoIcons.cart_fill_badge_plus,
    // ),
    // SlidableAction(
    //   onPressed: (ctx) {},
    //   backgroundColor: AppColors.red,
    //   foregroundColor: AppColors.darkGreen,
    //   icon: CupertinoIcons.delete_solid,
    // );
  }
}
