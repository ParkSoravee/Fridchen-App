import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fridchen_app/screens/bottomsheets/fridge_new_item.dart';
import 'package:fridchen_app/widgets/dialog_confirm.dart';
import 'package:fridchen_app/widgets/tag_list.dart';
import 'package:provider/provider.dart';

import '../providers/list.dart';
import '../themes/color.dart';
import 'dialog_alert.dart';

class ListListItem extends StatefulWidget {
  final ListItem item;
  const ListListItem({Key? key, required this.item}) : super(key: key);

  @override
  State<ListListItem> createState() => _ListListItemState();
}

class _ListListItemState extends State<ListListItem> {
  bool isTick = false;

  Future<void> toggleTick() async {
    isTick = !isTick;
    // Provider.of<ListItems>(context, listen: false).setTick(widget.item.id);
    // setState(() {});
    try {
      // TODO: api tick

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

  Future<void> deleteItem() async {
    print('delete');
    try {
      // Provider.of<ListItems>(context, listen: false).deleteItem(widget.item.id);
      // TODO: api delete item
    } catch (e) {
      print(e);
      //TODO: show bottom error
    }
  }

  Future<void> addToFridge(Function? setIsConfirm) async {
    if (setIsConfirm == null) {
      setIsConfirm = () {
        deleteItem();
      };
    }
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.darkGreen.withOpacity(0.70),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: FridgeNewItem(
          name: widget.item.name,
          setIsComfirm: setIsConfirm,
        ), // TODO: default value
      ),
    );
  }

  @override
  void initState() {
    isTick = widget.item.isTick;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
      child: Slidable(
        key: widget.key!,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            closeOnCancel: true,
            onDismissed: deleteItem,
            confirmDismiss: () async {
              bool isDel = false;
              await addToFridge(() {
                isDel = true;
              });
              return isDel;
            },
          ),
          extentRatio: 0.4,
          children: [
            CustomSlidableAction(
              onPressed: (_) async {
                await showDialog(
                  context: context,
                  builder: (ctx) => DialogConfirm(
                    title: 'Are you sure?',
                    primaryColor: AppColors.yellow,
                    backgroundColor: AppColors.darkGreen,
                    confirm: () {
                      deleteItem();
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              backgroundColor: AppColors.red,
              foregroundColor: AppColors.darkGreen,
              child: Icon(
                CupertinoIcons.delete_solid,
                color: AppColors.darkGreen,
                size: 30,
              ),
            ),
            CustomSlidableAction(
              onPressed: (ctx) async {
                await addToFridge(null);
              },
              backgroundColor: AppColors.lightGreen,
              foregroundColor: AppColors.darkGreen,
              child: Image.asset(
                'assets/images/fridge.png',
                color: AppColors.darkGreen,
                height: 30,
              ),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          decoration: BoxDecoration(
            color: AppColors.darkGreen,
          ),
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: toggleTick,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isTick
                          ? Icon(
                              Icons.done,
                              color: AppColors.darkGreen,
                              size: 35,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
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
                      ],
                    ),
                    Divider(
                      color: AppColors.yellow,
                      height: 6,
                      thickness: 2.5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TagList(tags: widget.item.tags),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
