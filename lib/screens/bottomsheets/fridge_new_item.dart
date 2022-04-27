import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fridchen_app/providers/api.dart';
import 'package:fridchen_app/providers/auth.dart';
import 'package:fridchen_app/providers/family.dart';
import 'package:fridchen_app/providers/fridges.dart';
import 'package:fridchen_app/providers/unit.dart';
import 'package:fridchen_app/themes/color.dart';
import 'package:fridchen_app/utils/date.dart';
import 'package:fridchen_app/widgets/bottom_sheet_template.dart';
import 'package:fridchen_app/widgets/row_with_title.dart';
import 'package:fridchen_app/widgets/snack_bar.dart';
import 'package:fridchen_app/widgets/tag_select.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../providers/tags.dart';
import '../../widgets/dialog_alert.dart';

class FridgeNewItem extends StatefulWidget {
  final FridgeItem? item;
  final Function? setIsComfirm;
  final String? name;
  final List<String>? tagIds;

  const FridgeNewItem({
    Key? key,
    this.setIsComfirm,
    this.item,
    this.name,
    this.tagIds,
  }) : super(key: key);

  @override
  State<FridgeNewItem> createState() => _FridgeNewItemState();
}

class _FridgeNewItemState extends State<FridgeNewItem> {
  final _form = GlobalKey<FormState>();
  final _volumnFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _volumnController = TextEditingController();
  final _minController = TextEditingController();

  String? _id;
  String? _name;
  DateTime? _exp;
  double? _volume;
  double? _min;
  double? _max;
  String? _selectedUnit;
  List<String> _tagsId = [];

  Future<void> setExpDate() async {
    final date = await MyDateUtils.setExpDate(
      context: context,
      title: 'EXP',
      initDate: widget.item == null
          ? DateTime.now().add(Duration(days: 2))
          : widget.item!.exp == null
              ? DateTime.now().add(Duration(days: 2))
              : widget.item!.exp!,
    );
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

  Future<void> submitForm() async {
    // print('confirm');
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    print(_name);
    print(_exp.toString());
    print(_volume);
    print(_selectedUnit);
    print(_min);
    print(_tagsId.toString());

    final fridgeItem = FridgeItem(
      name: _name!,
      exp: _exp,
      countLeft: _volume!,
      unitIds: Provider.of<Units>(context, listen: false)
          .getIdByName(_selectedUnit!),
      tagIds: _tagsId,
      min: _min,
    );
    try {
      final familyId =
          Provider.of<Families>(context, listen: false).currentFamilyId;
      if (widget.item == null) {
        await Provider.of<Api>(context, listen: false)
            .addFridgeItem(familyId, fridgeItem);
      } else {
        await Provider.of<Api>(context, listen: false)
            .editFridgeItem(familyId, fridgeItem, widget.item!.id!);
      }
      if (widget.setIsComfirm != null) widget.setIsComfirm!();
      Navigator.pop(context);
      // TODO success

    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (ctx) => DialogAlert(
          title: 'Please connect the internet.',
          // title: e.toString(),
          smallTitle: true,
          primaryColor: AppColors.white,
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    if (widget.name != null) {
      _nameController.text = widget.name!;
    }

    if (widget.tagIds != null) {
      _tagsId = widget.tagIds!;
    }

    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _volumnController.text = widget.item!.countLeft.toString();
      _minController.text =
          widget.item!.min == null ? '' : widget.item!.min.toString();
      _tagsId = widget.item!.tagIds;
      // print(_tagsId);
      _selectedUnit = Provider.of<Units>(context, listen: false)
          .getNameById(widget.item!.unitIds);
      _exp = widget.item!.exp;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetTemplate(
      background: AppColors.green,
      title: widget.item == null ? 'Add in fridge' : 'Edit Fridge',
      submitForm: submitForm,
      child: Form(
        key: _form,
        child: Column(
          children: [
            RowWithTitle(
              title: 'NAME : ',
              child: [
                Expanded(
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: InputBorder.none,
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(12, 6, 12, 2),
                    ),
                    enableSuggestions: false,
                    autocorrect: false,
                    cursorColor: AppColors.lightGreen,
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
                        return 'Please enter item name.';
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
                Expanded(
                  child: Container(
                    child: TextFormField(
                      controller: _volumnController,
                      focusNode: _volumnFocusNode,
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
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter item amount or volume.';
                        }

                        if (double.tryParse(value) == null) {
                          return 'Invalid volume.';
                        }

                        if (double.parse(value) > 10000 ||
                            double.parse(value) <= 0) {
                          return 'Invalid volume.';
                        }

                        if (_selectedUnit == null) {
                          return 'Invalid unit.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _volume = double.parse(value!);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    menuMaxHeight: 220,
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
                    items: Provider.of<Units>(context, listen: false)
                        .getDropdownMenuItem(20, AppColors.darkGreen),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnit = value.toString();
                      });
                    },
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
                    controller: _minController,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // return 'Please enter min.';
                        return null;
                      }

                      if (double.tryParse(value) == null) {
                        return 'Invalid min.';
                      }

                      if (double.parse(value) > 10000 ||
                              double.parse(value) <= 0
                          // || double.parse(value) >= _volume!
                          ) {
                        return 'Invalid min.';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _min = double.tryParse(value!);
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
                  tags: Provider.of<Tags>(context, listen: false).defaultTags,
                  setSelectedTags: setSelectedTags,
                  selectedTagsId: _tagsId,
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
