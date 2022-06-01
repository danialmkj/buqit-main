

import 'dart:io';

import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/States/Profile/ProfileProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Utils/Constants.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ContactPage extends HookWidget{
  @override
  Widget build(BuildContext context) {

    final textController=useTextEditingController();

    final enable=useState(false);
    return Scaffold(
      appBar: CustomAppbar(title:"Support"),
      body:SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(

                onChanged: (t){
                  if(t==""){
                    enable.value=false;
                  }else{
                    enable.value=true;
                  }
                },
                maxLength: 120,
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
                maxLines: 10,
                buildCounter: (_, {required currentLength, maxLength, required isFocused}) => Typo(text: "$currentLength/$maxLength"),
                controller: textController,

              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      primary: Colour.primaryBlue),
                  onPressed: !enable.value ? null : ()async{

                    String? userId= Provider.of<AuthProvider>(context,listen: false).profile!.id;

                    String platform="";

                    if (Platform.isAndroid) {
                      platform="android";
                      // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                      // meta['deviceModel'] = androidInfo.manufacturer;
                      // print(androidInfo.manufacturer);
                    } else if (Platform.isIOS) {
                      platform="IOS";
                      // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                      //
                      // print(iosInfo);
                    }


                    Dia.post(context,Api.CONTACT,data:{
                      "userId":userId,
                      "context":textController.text,
                      "appVersion":Constants.appVersion,
                      "platform":platform
                    }).then((res){


                          Navigator.of(context).pop();

                          Fluttertoast.showToast(
                              msg: "Feedback submitted successfully.",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.green,
                              textColor: Colors.white);


                    }).catchError((e){});
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Typo(text:"Done",size:16)),
                ),
              ),
             
            ],
          ),
        ),
      )
    );
  }

}