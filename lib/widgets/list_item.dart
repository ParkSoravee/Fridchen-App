import 'package:flutter/material.dart';
import 'package:fridchen_app/widgets/tag_list.dart';

import '../providers/list.dart';
import '../themes/color.dart';

class ListListItem extends StatefulWidget {
  final ListItem item;
  const ListListItem({Key? key, required this.item}) : super(key: key);

  @override
  State<ListListItem> createState() => _ListListItemState();
}

class _ListListItemState extends State<ListListItem> {
  bool isTick = false;
  void toggleTick() {
    isTick = !isTick;
    // Provider.of<ListItems>(context, listen:false).tickById(item.id);
    setState(() {});
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
      child: Dismissible(
        key: widget.key!,
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
                            ],
                          ),
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
