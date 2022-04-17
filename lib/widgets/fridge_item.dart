import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/tag_list.dart';

class FridgeListItem extends StatefulWidget {
  final FridgeItem item;

  const FridgeListItem(this.item);

  @override
  State<FridgeListItem> createState() => _FridgeListItemState();
}

class _FridgeListItemState extends State<FridgeListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.red,
      ),
      child: Dismissible(
        key: ValueKey(widget.item.id),
        background: Container(
          decoration: BoxDecoration(
            color: AppColors.red,
          ),
          child: Icon(Icons.abc),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: AppColors.green,
          ),
          child: Icon(Icons.abc),
        ),
        direction: DismissDirection.endToStart,
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
                    child: Text(
                      widget.item.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Text(
                    widget.item.exp == null
                        ? 'EXP'
                        : 'EXP ${DateFormat('dd MMM yyyy').format(widget.item.exp!)}',
                    style: TextStyle(
                      color: Colors.white,
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
                    '${widget.item.countLeft} ${widget.item.unit}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
