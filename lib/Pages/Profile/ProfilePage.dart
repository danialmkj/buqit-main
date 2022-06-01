

import 'package:buqit/Models/Profile/Profile.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/Profile/UpdateProfileFields.dart';
import 'package:buqit/Pages/Profile/widgets/ProfileFieldSection.dart';
import 'package:buqit/Pages/Profile/widgets/ProfileImagePicker.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/States/Profile/ProfileProvider.dart';
import 'package:buqit/Utils/DateUtility.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Buttons/SplashTouch.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ProfilePage extends HookWidget{
  @override
  Widget build(BuildContext context) {


    Profile? profile=Provider.of<AuthProvider>(context).profile;



    return Scaffold(
      appBar: CustomAppbar(
        title: "Account",
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: SplashTouch(

              padding: EdgeInsets.symmetric(horizontal: 15),
              onTap: (){
                Provider.of<AuthProvider>(context,listen: false).logOut(context);
              },
              child: const Icon(CupertinoIcons.square_arrow_right,size:25),color: Colors.transparent,round: 50,splashColor: Colors.blueAccent.withOpacity(0.3),),
          )
        ],
      ),
      body: Container(
        child: Column(

          children: [
              Container(
                padding:const EdgeInsets.only(top: 15),
                margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.3,color: Colors.grey)
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Typo(text: "Profile",size:20,bold:true),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Typo(text: "Some info may be visible to other people using BuQuit services.",maxLines: 2,),
                    ),
                    const SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(

                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Typo(text: "PHOTO"),
                                Typo(text: "A picture helps providers recognise you and lets you know when you're signed into your account.",maxLines: 3,)
                              ],
                            ),
                          ),

                          ProfileImagePicker(firstName: profile!.firstName, onAdd: (imagePath){
                            Provider.of<AuthProvider>(context).updateImage(context,imagePath: imagePath,onSuccess: (res){

                            });

                          }, onRemove: (){

                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    ProfileFieldSetion(title:"FIRST NAME" , value: profile.firstName, onTap: (){
                      Navigator.of(context).pushNamed(Pages.updateProfile,arguments: FieldType.firstName);

                    }),
                    ProfileFieldSetion(title:"LAST NAME" , value: profile.lastName, onTap: (){
                      Navigator.of(context).pushNamed(Pages.updateProfile,arguments: FieldType.lastName);
                    }),
                    ProfileFieldSetion(title:"PASSWORD" , value: "**********",noBorder: true ,onTap: (){
                      Navigator.of(context).pushNamed(Pages.updatePassword);
                    },subtitle:profile.updates.lastPasswordUpdate !=null ? "Last changed ${DateUtility(dateTime: profile.updates.lastPasswordUpdate!,).timeAgo()}" : null,),
                  ],
                ) ,
              ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
              padding:const EdgeInsets.only(top: 15),

              decoration: BoxDecoration(
                  border: Border.all(width: 0.3,color: Colors.grey)
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(

                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Typo(text: "Contact Info ",size:18,bold:true),
                  ),
                  const SizedBox(height: 15,),



                  ProfileFieldSetion(title:"EMAIL" , value: profile.email, onTap: (){
                    Navigator.of(context).pushNamed(Pages.updateProfile,arguments: FieldType.email);
                  }),
                  ProfileFieldSetion(title:"PHONE" , value: profile.phone, onTap: (){
                    Navigator.of(context).pushNamed(Pages.updateProfile,arguments: FieldType.phone);
                  },noBorder: true,),
                ],
              ) ,
            ),

          ],
        ),
      ),
    );
  }

}