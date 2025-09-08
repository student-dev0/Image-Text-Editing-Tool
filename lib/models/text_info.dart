import 'package:flutter/material.dart';

class TextInfo {
  String text;
  double left;
  double top;
  Color color;
  FontStyle fontstyle;
  FontWeight fontweight;
  double fontsize;
  TextAlign textalign;

  TextInfo({
    required this.color,
    required this.text,
    required this.left,
    required this.top,
    required this.fontweight,
    required this.fontsize,
    required this.textalign,
    required this.fontstyle
  });
}
