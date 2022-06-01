



import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/AppState/AppProvider.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'widgets/SettingSection.dart';

class SettingPage extends HookWidget{
  @override
  Widget build(BuildContext context) {


    final switchValue=useState(false);


    return Scaffold(
      appBar: CustomAppbar(
        title: "Setting",
      ),
      body: Container(
        child: Column(
          children: [
            SettingSection(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Typo(text: "Dark Theme",size:16),
                    Switch(value:switchValue.value, onChanged: (bool value) {
                      switchValue.value=value;
                      Provider.of<AppProvider>(context,listen: false).switchDark();
                      },)
                  ],
                )
            ),

            SettingSection(
                child:GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(Pages.notificationSetting);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Typo(text: "Notification",size:16),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                )
            ),
          ],

        ),
      ),
    );
  }

}