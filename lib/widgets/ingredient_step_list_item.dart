import 'package:flutter/material.dart';
import 'package:fridchen_app/themes/color.dart';

class IngredientStepListItem extends StatelessWidget {
  final String name;
  final String? amount;
  final Function(int)? onDelete;
  final int index;

  const IngredientStepListItem({
    Key? key,
    required this.name,
    required this.index,
    this.amount,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 35,
      padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              softWrap: true,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          if (amount != null)
            Text(
              amount!,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          SizedBox(
            width: 5,
          ),
          if (onDelete != null)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  onDelete!(index);
                },
                borderRadius: BorderRadius.circular(20),
                child: Icon(
                  Icons.cancel,
                  color: AppColors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
