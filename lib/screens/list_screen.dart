import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/list.dart';
import 'package:fridchen_app/screens/template_screen.dart';
import 'package:provider/provider.dart';

import '../providers/tags.dart';
import '../themes/color.dart';
import '../widgets/list_item.dart';
import '../widgets/search_bar.dart';
import 'bottomsheets/list_new_item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String searchStr = '';
  List<String> searchTags = [];
  bool isSearch = false;

  void setTags(List<String> tags) {
    searchTags = tags;
    setSearch();
  }

  void setStr(String str) {
    searchStr = str;
    setSearch();
  }

  void setSearch() {
    if (searchStr.length > 0 || searchTags.length > 0) {
      isSearch = true;
    } else {
      isSearch = false;
    }
    setState(() {});
  }

  void addNewList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.darkGreen.withOpacity(0.70),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ListNewItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultTags = Provider.of<Tags>(context, listen: false).defaultTags;
    final listItem = Provider.of<ListItems>(context);
    final listItemList =
        isSearch ? listItem.search(searchStr, searchTags) : listItem.items;

    return TemplateScreen(
      title: 'LIST',
      primaryColor: AppColors.yellow,
      secondaryColor: AppColors.orange,
      addNew: addNewList,
      child: Column(
        children: [
          SearchBar(
            tags: defaultTags,
            color: AppColors.orange,
            bgColor: AppColors.yellow,
            setSearchStr: setStr,
            setTags: setTags,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 12,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: ListView.builder(
                itemBuilder: (ctx, i) => ListListItem(
                  key: ValueKey(listItemList[i].id),
                  item: listItemList[i],
                ),
                itemCount: listItemList.length,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
