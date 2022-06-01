

import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';

class ProfileFieldSetion extends StatelessWidget {

  String title;
  String value;
  Function onTap;
  bool noBorder;
  String? subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child:Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        decoration: BoxDecoration(
          border: Border(bottom:!noBorder ? BorderSide(width: 0.4,color: Colors.grey) : BorderSide.none)
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Typo(text:title,color:Colors.grey),
                SizedBox(height: 2,),
                Typo(text: value,size:18,),
                if(subtitle!=null)Typo(text: subtitle!,size:14,color:Colors.grey),

              ],
            ),
            Icon(Icons.chevron_right,color:Colors.grey,size: 25,)
          ],
        ),
      ) ,
    );
  }

  ProfileFieldSetion({
    required this.title,
    required this.value,
    required this.onTap,
    this.subtitle,
     this.noBorder=false,
  });
}
