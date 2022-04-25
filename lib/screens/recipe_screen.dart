import 'package:flutter/material.dart';
import 'package:fridchen_app/screens/bottomsheets/recipe_new_item.dart';
import 'package:fridchen_app/screens/template_screen.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:provider/provider.dart';

import '../providers/recipes.dart';
import '../providers/tags.dart';
import '../widgets/recipe_item.dart';
import '../widgets/search_bar.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({Key? key}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
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

  void addNewRecipe() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.darkGreen.withOpacity(0.70),
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: RecipeNewItem(
          onEdit: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultTags = Provider.of<Tags>(context, listen: false).defaultTags;
    final recipes = Provider.of<Recipes>(context);
    final recipeList =
        isSearch ? recipes.search(searchStr, searchTags) : recipes.items;

    return TemplateScreen(
      title: 'RECIPE',
      primaryColor: AppColors.orange,
      secondaryColor: AppColors.yellow,
      addNew: addNewRecipe,
      child: Column(
        children: [
          SearchBar(
            tags: defaultTags,
            color: AppColors.yellow,
            bgColor: AppColors.orange,
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
                itemBuilder: (ctx, i) => RecipeListItem(
                  key: ValueKey(recipeList[i].id),
                  item: recipeList[i],
                ),
                itemCount: recipeList.length,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
