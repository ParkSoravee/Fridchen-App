import 'package:flutter/material.dart';

class Menus extends StatelessWidget {
  final String image;
  final String title;
  final Color color;
  final double size;

  const Menus({
    required this.image,
    required this.title,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
          margin: EdgeInsets.only(bottom: 3, top: size / 4),
          height: size,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(color: color, fontSize: 36),
        )
      ],
    );
  }
}
