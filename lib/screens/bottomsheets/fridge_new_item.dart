import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/utils/date.dart';
import 'package:fridchen_app/widgets/bottom_sheet_template.dart';
import 'package:fridchen_app/widgets/row_with_title.dart';
import 'package:fridchen_app/widgets/tag_list.dart';
import 'package:fridchen_app/widgets/tag_select.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/tags.dart';

class FridgeNewItem extends StatefulWidget {
  const FridgeNewItem({Key? key}) : super(key: key);

  @override
  State<FridgeNewItem> createState() => _FridgeNewItemState();
}

class _FridgeNewItemState extends State<FridgeNewItem> {
  String? _name;
  DateTime? _exp;
  double? _volumn;
  double? _min;
  double? _max;
  String? _selectedUnit;
  List<String> _tagsId = [];

  List<DropdownMenuItem<String>> dropDownItems = [
    'Pieces',
    'Grams',
    'Kilograms',
    'Litre',
    'Millilitre',
    'Ounce',
    'CC',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(
          color: AppColors.darkGreen,
          fontSize: 20,
        ),
      ),
    );
  }).toList();

  Future<void> setExpDate() async {
    final date = await MyDateUtils.setExpDate(context: context, title: 'EXP');
    if (date != null) {
      _exp = date;
      setState(() {});
    }
  }

  void setSelectedTags(String tagId) {
    final result =
        _tagsId.firstWhere((element) => element == tagId, orElse: () => '');
    if (result == '') {
      _tagsId.add(tagId);
    } else {
      _tagsId.remove(tagId);
    }
  }

  void submitForm() {
    print('confirm');
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTemplate(
      background: AppColors.green,
      title: 'Add in fridge',
      submitForm: submitForm,
      child: Form(
        child: Column(
          children: [
            RowWithTitle(
              title: 'NAME : ',
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
                    cursorColor: AppColors.lightGreen,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                  ),
                ),
              ],
            ),
            RowWithTitle(
              title: 'EXP : ',
              child: [
                Material(
                  color: Colors.transparent,
                  child: _exp == null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          // child: Material(
                          //   color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              await setExpDate();
                            },
                            borderRadius: BorderRadius.circular(5),
                            child: Icon(
                              CupertinoIcons.calendar_badge_plus,
                              color: AppColors.white,
                              size: 40,
                            ),
                          ),
                          // ),
                        )
                      : InkWell(
                          onTap: () async {
                            await setExpDate();
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              '${DateFormat('dd MMM yyyy').format(_exp!)}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 36,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
            RowWithTitle(
              title: 'VOLUME : ',
              child: [
                Container(
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                    ),
                    cursorColor: AppColors.lightGreen,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  // margin: EdgeInsets.only(left: 10),
                  // width: 90,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      // decoration: ,
                      value: _selectedUnit,
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      hint: Text(
                        'Select unit',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                      ),
                      items: dropDownItems,
                      onChanged: (value) {
                        setState(() {
                          _selectedUnit = value.toString();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            RowWithTitle(
              title: 'MIN : ',
              child: [
                Container(
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                    ),
                    cursorColor: AppColors.lightGreen,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            RowWithTitle(
              title: 'MAX : ',
              child: [
                Container(
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                    ),
                    cursorColor: AppColors.lightGreen,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
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
          ],
        ),
      ),
    );
  }
}
