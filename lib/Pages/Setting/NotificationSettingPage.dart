

import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class NotificationSettingPage extends HookWidget{
  @override
  Widget build(BuildContext context) {


    bool notificationSetting=Provider.of<AuthProvider>(context).profile!.settings.notificationsEnabled;

    final notificationValue=useState(notificationSetting);

    return Scaffold(
      appBar: CustomAppbar(
        title: "Notification Setting",
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Typo(
                maxLines: 4,
                size:16,
                text: "We occasionally send you the latest product news and promotional offers. In order to benefit, stay opted in. By opting out, you will not receive any newsletters or offers. You can always change this."
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(child: Typo(text: "I want to receive BuQit news and service discounts.",maxLines: 2,bold:true,size:17)),
              Switch(value: notificationValue.value, onChanged: (v){

                Provider.of<AuthProvider>(context,listen: false).setNotification(context,toggle:v,onSuccess:(r){
                  notificationValue.value=v;

                });
              })
            ],)
          ],
        ),
      ),
    );
  }
}