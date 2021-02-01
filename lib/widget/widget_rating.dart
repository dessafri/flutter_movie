import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final int rating;
  final int index;

  Rating({this.rating, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: index <= rating / 2
          ? Image.asset("assets/icon_star.png")
          : Container(),
    );
  }
}
