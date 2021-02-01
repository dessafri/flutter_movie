import 'package:flutter/material.dart';

class ButtonAction extends StatelessWidget {
  final String imageUrl;

  ButtonAction({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 50,
        child: Image.asset(imageUrl),
      ),
    );
  }
}
