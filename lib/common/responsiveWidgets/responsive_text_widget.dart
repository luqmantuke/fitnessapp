// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyResponsiveTextWidget extends StatelessWidget {
  final String text;
  final double desktopFontSizeValue;
  final double tabletFontSizeValue;
  final double mobileFontSizeValue;
  final Color textColor;
  FontWeight? fontWeight;
  MyResponsiveTextWidget(
      {Key? key,
      required this.text,
      required this.desktopFontSizeValue,
      required this.tabletFontSizeValue,
      required this.mobileFontSizeValue,
      required this.textColor,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: ResponsiveValue(context, defaultValue: 13.0, valueWhen: [
            Condition.largerThan(name: TABLET, value: desktopFontSizeValue),
            Condition.smallerThan(name: DESKTOP, value: tabletFontSizeValue),
            Condition.smallerThan(name: TABLET, value: mobileFontSizeValue),
          ]).value),
    );
  }
}
