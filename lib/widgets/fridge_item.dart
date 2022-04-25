import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/list.dart';
import 'package:fridchen_app/utils/date.dart';
import 'package:fridchen_app/widgets/dialog_confirm.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/tag_list.dart';
import 'package:provider/provider.dart';

import '../screens/bottomsheets/fridge_new_item.dart';
import 'dialog_consume.dart';

class FridgeListItem extends StatefulWidget {
  final FridgeItem item;

  const FridgeListItem({Key? key, required this.item}) : super(key: key);

  @override
  State<FridgeListItem> createState() => _FridgeListItemState();
}

class _FridgeListItemState extends State<FridgeListItem> {
  Future<void> setExpDate() async {
    try {
      final date = await MyDateUtils.setExpDate(
          context: context, title: widget.item.name);
      if (date != null) {
        Provider.of<FridgeItems>(context, listen: false)
            .setExp(widget.item.id!, date);
      }
      // TODO: bottom success
    } catch (e) {
      // TODO: bottom error
    }
  }

  Future<void> setStar() async {
    bool isConfirm = false;
    await showDialog(
      context: context,
      builder: (_) => DialogConfirm(
        isCenterTitle: true,
        smallTitle: true,
        title: !widget.item.isStar
            ? 'Are you sure to star this?'
            : 'Are you sure to un-star this?',
        primaryColor: AppColors.darkGreen,
        backgroundColor: AppColors.green,
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
              !widget.item.isStar
                  ? 'this ingredients will be added\nto your shopping list immediately\nwhen it less than your minimum value.'
                  : 'this ingredients won\'t be added\nto your shopping list when it\nless than your minimum value.',
              style: TextStyle(
                color: AppColors.darkGreen,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

    if (!isConfirm) return;

    try {
      await Provider.of<FridgeItems>(context, listen: false)
          .setStar(widget.item.id!);
      // TODO: bottom success
    } catch (e) {
      // TODO: bottom error
    }
  }

  Future<void> addToList() async {
    try {
      Provider.of<ListItems>(context, listen: false)
          .addNewItem(widget.item.name, widget.item.tags);
      // TODO: bottom success
    } catch (e) {
      // TODO: bottom error
    }
  }

  Future<void> deleteItem() async {
    bool isConfirm = false;
    await showDialog(
      context: context,
      builder: (_) => DialogConfirm(
        isCenterTitle: true,
        smallTitle: true,
        title: 'Are you sure to delete this?',
        primaryColor: AppColors.darkGreen,
        backgroundColor: AppColors.green,
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
          ],
        ),
      ),
    );
    if (!isConfirm) return;

    try {
      Provider.of<FridgeItems>(context, listen: false)
          .deleteItem(widget.item.id!);
      // TODO: bottom success
    } catch (e) {
      // TODO: bottom error
    }
  }

  Future<void> consumeItem() async {
    bool isConfirm = false;
    double amount = 0.0;
    await showDialog(
      context: context,
      builder: (_) => DialogConsume(
        item: widget.item,
        isConfirm: (am) {
          isConfirm = true;
          amount = am;
        },
      ),
    );
    if (!isConfirm) return;

    try {
      Provider.of<FridgeItems>(context, listen: false)
          .consumeItem(widget.item.id!, amount);
      // TODO: bottom success
    } catch (e) {
      // TODO: bottom error
    }
  }

  void editFridgeItem() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.darkGreen.withOpacity(0.70),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: FridgeNewItem(item: widget.item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: consumeItem,
      onLongPress: editFridgeItem,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        child: Slidable(
          key: ValueKey(widget.item.id),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.5,
            children: [
              SlidableAction(
                onPressed: (_) async {
                  await setStar();
                },
                backgroundColor: AppColors.yellow,
                foregroundColor: AppColors.darkGreen,
                icon: Icons.star_rounded,
              ),
              SlidableAction(
                onPressed: (_) async {
                  await addToList();
                },
                backgroundColor: AppColors.lightGreen,
                foregroundColor: AppColors.darkGreen,
                icon: CupertinoIcons.cart_fill_badge_plus,
              ),
              SlidableAction(
                onPressed: (_) async {
                  await deleteItem();
                },
                backgroundColor: AppColors.red,
                foregroundColor: AppColors.darkGreen,
                icon: CupertinoIcons.delete_solid,
              )
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
      ),
    );
  }
}
