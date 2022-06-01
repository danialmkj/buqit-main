import 'dart:convert';


import 'package:buqit/Widgets/Buttons/SplashTouch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import '../Typo.dart';



class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {

  List<Widget>? actions;
  String title;
  Color? color;


  CustomAppbar(
      {
         this.actions=const [],
        required this.title,
        this.color
      })
      : preferredSize = Size.fromHeight(60.0),
        super();

  @override
  Size preferredSize; // default is 56.0

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {


    return AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        leading: SplashTouch(

          onTap: (){
            Navigator.of(context).pop();
          },
          child:  Icon(Icons.arrow_back,size:25,color: widget.color ?? Theme.of(context).textTheme.subtitle1?.color ),color: Colors.transparent,round: 50,splashColor: Colors.blueAccent.withOpacity(0.3),),
        title:Typo(text:widget.title,size:20,bold:true,color:widget.color ?? Theme.of(context).textTheme.subtitle1?.color),
        iconTheme:  IconThemeData(color: Theme.of(context).textTheme.subtitle1?.color),
        actions: [
          ...?widget.actions
        ],

        elevation: 0,
        backgroundColor: Colors.transparent
    );
  }
}


