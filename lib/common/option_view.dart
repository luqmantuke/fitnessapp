// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class OptionView extends StatelessWidget {
  Color color;
  String header;
  double padding;
  Color textColor;

  // ignore: use_key_in_widget_constructors
  OptionView(this.color, this.header,
      {this.padding = 8, this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Text(header,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontSize: 11)),
    );
  }
}
