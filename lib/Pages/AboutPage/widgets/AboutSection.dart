

import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class SectionItem{
  String title;
  Function onPress;

  SectionItem({
    required this.title,
    required this.onPress,
  });
}



class AboutSection extends HookWidget{



  List<SectionItem> items;


  @override
  Widget build(BuildContext context) {



    return Container(
      margin: EdgeInsets.only(bottom:40),
      decoration: BoxDecoration(border: Border(top:BorderSide(width: 0.3,color: Colors.grey.shade400))),
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch  ,
        children: [
          ...items.map((item) => InkWell(
            onTap: (){
              item.onPress();
            },
            child: Container(
              decoration: BoxDecoration(
                border:Border(bottom:BorderSide(width: 0.3,color:Colors.grey.shade400))
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Typo(text:item.title,size:16),
            ),
          ))
        ],
      )
    );
  }

  AboutSection({
    required this.items,
  });

}