

import 'package:buqit/Pages/AboutPage/widgets/AboutSection.dart';
import 'package:buqit/Utils/Constants.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends HookWidget{
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:CustomAppbar(title: "About",actions: [],) ,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: EdgeInsets.only(bottom:40),
                decoration: BoxDecoration(border: Border(top:BorderSide(width: 0.3,color: Colors.grey.shade400))),
                child : InkWell(
                  onTap: (){

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border:Border(bottom:BorderSide(width: 0.3,color:Colors.grey.shade400))
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Typo(text:"App Version",size:16),
                        Typo(text:Constants.appVersion,size:16),
                      ],
                    )
                  ),
                )),
            AboutSection(
              items: [
                SectionItem(title: "Facebook", onPress: (){
                  launch("https://www.facebook.com/buqit_app");

                }),
                SectionItem(title: "Instagram", onPress: (){
                  launch("https://www.instagram.com/buqitapp");
                }),
                SectionItem(title: "Twitter", onPress: (){
                  launch("https://www.twitter.com/buqitapp");

                }),
              ],),
            AboutSection(
              items: [
                SectionItem(title: "BuQuit Careers", onPress: (){
                  launch("https://buqit.com/careers");
                }),
              ],),

            AboutSection(
              items: [
                // SectionItem(title: "Open source licenses", onPress: (){}),
                SectionItem(title: "Terms and Conditions", onPress: (){
                  launch("https://buqit.com/terms-and-conditions");


                }),
              ],),
          ],
        ),
      ),
    );
  }

}