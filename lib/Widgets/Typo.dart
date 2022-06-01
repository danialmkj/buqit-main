import 'package:flutter/material.dart';


class Typo extends StatefulWidget {



  String text;
  bool bold;
  Color? color;
  int size;
  int maxLines;
  bool englishDigit;
  double lineSpacing;
  TextStyle? style;
  TextAlign? align;

  Typo(
      {
        required this.text,
        this.size=14,
        this.lineSpacing=1.35,
        this.bold=false,
        this.color,
        this.maxLines=1,
        this.englishDigit:false,
        this.style,
        this.align
      });



  @override
  _LoadingState createState() => _LoadingState();
}




class _LoadingState extends State<Typo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(

          widget.text,
          overflow: TextOverflow.ellipsis,
          textAlign: widget.align !=null ? widget.align : TextAlign.left,
          maxLines: widget.maxLines,
          style: widget.style ?? TextStyle(
              height: widget.lineSpacing,
              color: widget.color!=null ? widget.color : null,
              fontSize: widget.size.toDouble(),
              fontWeight: widget.bold ? FontWeight.bold : null),
        ));
  }
}
