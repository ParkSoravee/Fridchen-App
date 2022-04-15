import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/tags.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/tag_item.dart';

class SearchBar extends StatefulWidget {
  final Color color;
  final Color bgColor;
  final List<Tag> tags;

  const SearchBar({
    required this.color,
    required this.bgColor,
    this.tags = const [],
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 37,
            padding: EdgeInsets.only(left: 17, right: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (str) {
                      print(str.trim());
                      // print();
                      // TODO: function set str
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: widget.color,
                      ),
                      contentPadding: EdgeInsets.only(bottom: 8),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: AppColors.darkGreen,
                      fontSize: 24,
                    ),
                  ),
                ),
                Icon(
                  CupertinoIcons.search,
                  size: 27,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 30, // TODO: check to get rid after tags have sized!
            width: double.infinity,
            child: ListView.builder(
              clipBehavior: Clip.antiAlias,
              scrollDirection: Axis.horizontal,
              itemCount: widget.tags.length,
              itemBuilder: (ctx, i) {
                return TagItem(widget.tags[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
