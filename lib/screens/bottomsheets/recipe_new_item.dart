import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/widgets/bottom_sheet_template.dart';
import 'package:fridchen_app/widgets/row_with_title.dart';
import 'package:provider/provider.dart';

import '../../providers/tags.dart';
import '../../widgets/tag_select.dart';

class RecipeNewItem extends StatefulWidget {
  const RecipeNewItem({Key? key}) : super(key: key);

  @override
  State<RecipeNewItem> createState() => _RecipeNewItemState();
}

class _RecipeNewItemState extends State<RecipeNewItem> {
  final _form = GlobalKey<FormState>();

  String? _name;
  List<String> _tagsId = [];

  void setSelectedTags(String tagId) {
    final result =
        _tagsId.firstWhere((element) => element == tagId, orElse: () => '');
    if (result == '') {
      _tagsId.add(tagId);
    } else {
      _tagsId.remove(tagId);
    }
  }

  void submitForm() {}

  @override
  Widget build(BuildContext context) {
    return BottomSheetTemplate(
      title: 'New Recipe',
      background: AppColors.orange,
      submitForm: submitForm,
      child: Form(
        key: _form,
        child: Column(
          children: [
            RowWithTitle(
              title: 'Name : ',
              child: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                    ),
                    cursorColor: AppColors.yellow,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) async {
                      // FocusScope.of(context).requestFocus(_volumnFocusNode);
                      // await setExpDate();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name.';
                      }

                      if (value.length > 25) {
                        return 'Name can be only 1-25 characters.';
                      }

                      // if (value.contains(special)) {
                      //   return 'Name can have only 1-25 characters';
                      // }
                      return null;
                    },
                    onSaved: (value) {
                      // _name = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            RowWithTitle(
              title: 'Ingredients : ',
              child: [
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.white,
                  ),
                  padding: EdgeInsets.fromLTRB(4, 6, 10, 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_rounded,
                        // size: 32,
                        color: AppColors.orange,
                      ),
                      Text(
                        'New Ingredient',
                        style: TextStyle(
                          fontSize: 19,
                          color: AppColors.orange,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 140,
              color: Color(0x0A000000),
              // child: ,
            ),
            SizedBox(
              height: 8,
            ),
            RowWithTitle(
              title: 'Steps : ',
              child: [
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.white,
                  ),
                  padding: EdgeInsets.fromLTRB(4, 6, 10, 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_rounded,
                        // size: 32,
                        color: AppColors.orange,
                      ),
                      Text(
                        'New Step',
                        style: TextStyle(
                          fontSize: 19,
                          color: AppColors.orange,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 180,
              color: Color(0x0A000000),
              // child: ,
            ),
            SizedBox(
              height: 10,
            ),
            RowWithTitle(
              title: 'TAG : ',
              isAlignStart: true,
              child: [
                TagSelect(
                  tags: Provider.of<Tags>(context).defaultTags,
                  setSelectedTags: setSelectedTags,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
