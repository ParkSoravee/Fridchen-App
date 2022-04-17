import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fridchen_app/providers/fridges.dart';

class ItemsList extends StatefulWidget {
  final 
  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 0,
        itemBuilder: (ctx, i) {
          
        },
      ),
    );
  }
}
