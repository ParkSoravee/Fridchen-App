import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/fridge_item.dart';
import 'package:fridchen_app/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import '../providers/tags.dart';

class FridgeScreen extends StatefulWidget {
  const FridgeScreen({Key? key}) : super(key: key);

  @override
  State<FridgeScreen> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
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

  @override
  Widget build(BuildContext context) {
    final fridgeLists = isSearch
        ? Provider.of<FridgeItems>(context).items
        : Provider.of<FridgeItems>(context).items;

    final defaultTags = Provider.of<Tags>(context, listen: false).defaultTags;
    return TemplateScreen(
      title: 'FRIDGE',
      primaryColor: AppColors.lightGreen,
      secondaryColor: AppColors.green,
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            SearchBar(
              tags: defaultTags,
              color: AppColors.green,
              bgColor: AppColors.lightGreen,
              setSearchStr: setStr,
              setTags: setTags,
            ),
            // isSearch
            //     ? Text(
            //         'searching... ' + searchStr + searchTags.toString(),
            //         style: TextStyle(color: Colors.amber, fontSize: 30),
            //       )
            //     : Text(
            //         'not search',
            //         style: TextStyle(color: Colors.amber, fontSize: 30),
            //       ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 12,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: ListView.builder(
                  itemBuilder: (ctx, i) => FridgeListItem(fridgeLists[i]),
                  itemCount: fridgeLists.length,
                  padding: EdgeInsets.zero,
                  // physics: ScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
