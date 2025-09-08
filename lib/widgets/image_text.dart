import 'package:editing_tool/models/text_info.dart';
import 'package:flutter/material.dart';

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  const ImageText({super.key,required this.textInfo});

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textalign,
      style:TextStyle(fontSize: textInfo.fontsize,fontWeight: textInfo.fontweight,fontStyle: textInfo.fontstyle,color: textInfo.color,)
    );
  }
}
