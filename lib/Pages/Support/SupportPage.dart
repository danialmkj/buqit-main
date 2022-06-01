

import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SupportPage extends HookWidget{
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppbar(title: "Support",),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Typo(text: "Need more help?",bold:true,size:16),
            SizedBox(height: 5,),
            InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(Pages.contact);
              },
              child: Container(

                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color:Colour.primaryBlue
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Typo(text: "Contact us",bold:true,size:15,color:Colors.white),
                        // SizedBox(height: 5,),
                        Typo(text: "Tell us more and we'll help you",size:14,color:Colors.white),
                      ],
                    ),
                    Icon(Icons.chevron_right,color:Colors.white)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}