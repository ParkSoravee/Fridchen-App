import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/utils/date.dart';
import 'package:fridchen_app/widgets/bottom_sheet_template.dart';
import 'package:fridchen_app/widgets/row_with_title.dart';
import 'package:intl/intl.dart';

import '../../providers/tags.dart';

class FridgeNewItem extends StatefulWidget {
  const FridgeNewItem({Key? key}) : super(key: key);

  @override
  State<FridgeNewItem> createState() => _FridgeNewItemState();
}

class _FridgeNewItemState extends State<FridgeNewItem> {
  String? name;
  DateTime? exp;
  double? volumn;
  List<String> unit = ['Pieces'];
  double? min;
  double? max;
  List<Tag> tags = [];

  Future<void> setExpDate() async {
    final date = await MyDateUtils.setExpDate(context: context, title: 'EXP');
    if (date != null) {
      exp = date;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTemplate(
      background: AppColors.green,
      title: 'Add in fridge',
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
                  child: exp == null
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
                              '${DateFormat('dd MMM yyyy').format(exp!)}',
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
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 80,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      // decoration: ,
                      value: 'Pieces',
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Pieces',
                          child: Text('Pieces'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Grams',
                          child: Text('Grams'),
                        ),
                      ],
                      // items: items.map((String items) {
                      //   return DropdownMenuItem(
                      //     value: items,
                      //     child: Text(items),
                      //   );
                      // }).toList(),
                      onChanged: (sel) {},
                    ),
                  ),
                ),
              ],
            ),
            // TODO !
          ],
        ),
      ),
    );
  }
}
