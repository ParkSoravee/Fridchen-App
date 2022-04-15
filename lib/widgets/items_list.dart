import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fridchen_app/providers/fridges.dart';

class ItemsList extends StatefulWidget {
  final String search;

  const ItemsList(this.search);

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    final fridgeItemsData = Provider.of<FridgeItems>(context);

    return Container();
  }
}
