import 'package:flutter/material.dart';
import 'package:movieku/theme.dart';

class Button extends StatelessWidget {
  final String icon;
  final String name;

  Button({this.icon, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Spacer(),
          Container(
            width: 24,
            child: Image.asset(
              icon,
              color: orangeColor,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            name,
            style: orangeStyle.copyWith(fontSize: 10),
          ),
          Spacer()
        ],
      ),
    );
  }
}
