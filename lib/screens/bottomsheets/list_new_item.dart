import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/list.dart';
import 'package:fridchen_app/widgets/bottom_sheet_template.dart';
import 'package:provider/provider.dart';

import '../../providers/tags.dart';
import '../../themes/color.dart';
import '../../widgets/row_with_title.dart';
import '../../widgets/tag_select.dart';

class ListNewItem extends StatefulWidget {
  const ListNewItem({Key? key}) : super(key: key);

  @override
  State<ListNewItem> createState() => _ListNewItemState();
}

class _ListNewItemState extends State<ListNewItem> {
  final _form = GlobalKey<FormFieldState>();
  final primaryColor = AppColors.orange;
  final secondaryColor = AppColors.yellow;

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

  Future<void> submitForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;

    final _tags =
        Provider.of<Tags>(context, listen: false).getTagsById(_tagsId);
    // final item = ListItem(id: '123', name: _name!, tags: _tags);

    _form.currentState!.save();
    try {
      await Provider.of<ListItems>(context, listen: false).addNewItem(
        _name!,
        _tags,
      );
      Navigator.pop(context);
      // TODO vvv
      // widget.showSavedConfirm(_name);
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Okay'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTemplate(
      title: 'Add in list',
      isShort: true,
      background: primaryColor,
      submitForm: submitForm,
      child: Form(
        child: Column(
          children: [
            RowWithTitle(
              title: 'Name : ',
              child: [
                Expanded(
                  child: TextFormField(
                    key: _form,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                    ),
                    cursorColor: secondaryColor,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                    textInputAction: TextInputAction.done,
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
                      _name = value;
                    },
                  ),
                ),
              ],
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
