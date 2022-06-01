


import 'package:buqit/Models/Drawer/DrawerItemModel.dart';
import 'package:buqit/Models/Profile/Profile.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/States/Drawer/DrawerProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Widgets/Drawer/DrawerItem.dart';
import 'package:buqit/Widgets/ImageHandler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Typo.dart';









class Drawerax extends HookWidget {
  @override
  Widget build(BuildContext context) {


    List<DrawerItemModel> items=Provider.of<DrawerProvider>(context).items;
    Profile? profile=Provider.of<AuthProvider>(context).profile;
    bool loading=Provider.of<DrawerProvider>(context).loading;

    // useEffect((){
    //   if(items.isEmpty){
    //     Future.delayed(Duration(milliseconds: 10),(){
    //       Provider.of<DrawerProvider>(context,listen: false).getDrawerItems(context);
    //     });
    //
    //   }
    // },[]);


    double offset=50;


    print(loading);


    return Drawer(


        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){

                  Navigator.of(context).pushNamed(Pages.profile);
                },
                child: Container(
                  // height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  margin: const EdgeInsets.only(top:45),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.4,color:Colors.grey))
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        ImageHandler(round:50,size: 60, url:profile!.photoUrl,errorWidget:Typo(text:profile.firstName[0].toUpperCase(),size:23,bold:true) ,),

                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Typo(text:profile.firstName,bold:true,size:18),
                            const SizedBox(height: 5,),
                            RatingBar.builder(
                              initialRating:3,
                              minRating: 1,
                              maxRating: 5,
                              itemSize: 17,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              ignoreGestures: true,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,

                              ), onRatingUpdate: (double value) {  },

                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if(items.isNotEmpty)Expanded(
                child: Column(
                  children: [


                    Container(
                      // color:Colors.white,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [

                          // Container(
                          //   height: 50,
                          //   // decoration: BoxDecoration(
                          //   //     gradient: CustomGradient.renderGradient(CustomGradients.green)
                          //   // ),
                          //
                          //   child: Stack(
                          //     children: [
                          //       Positioned(
                          //           top:offset,
                          //           left:10,
                          //           child: IconButton( onPressed: () {  Scaffold.of(context).openEndDrawer();  }, icon:const Icon( Icons.close,color:Colors.white),)
                          //       ),
                          //       Positioned(
                          //           bottom:15,
                          //           left:10,
                          //           child: Row(
                          //             children: [
                          //               ClipRRect(
                          //                   borderRadius: BorderRadius.circular(200),
                          //                   child: Image.asset("assets/avatars/1.jpg",height: 55,width: 55,fit: BoxFit.cover,)),
                          //               SizedBox(width: 15,),
                          //               Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                 children: [
                          //                   Typo(text: "Mike",bold:true,size: 20,color:Colors.white),
                          //                   Typo(text: "mike@dolegate.com",color:Colors.white),
                          //                 ],
                          //               )
                          //             ],
                          //           )
                          //       )
                          //     ],
                          //   ),
                          // ),

                          ...items.where((element) => element.enabled).map((item) => DrawerItem(
                            drawerItem: item,
                          )).toList()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if(items.isEmpty) Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),

                  ),
                  child:loading ? const Align(alignment:Alignment.topCenter,child: CupertinoActivityIndicator(
                      animating:true,
                    radius: 18,
                  )) :  GestureDetector(
                      onTap: (){
                        Provider.of<DrawerProvider>(context,listen: false).getDrawerItems(context);
                      },
                      child: Column(
                        children: [

                          const Icon(Icons.refresh,size:30),
                          Typo(text: "Please try to refresh.",size:16)
                        ],
                      )),
                ),
              ),
              GestureDetector(
                onTap: (){
                  launch("https://play.google.com/store/apps/details?id=com.buqit.provider");
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color:Colour.primaryBlue
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Typo(text: "Become a service provider",bold:true,size:15,color:Colors.white),
                          // SizedBox(height: 5,),
                          Typo(text: "Earn money on your schedule",size:14,color:Colors.white),
                        ],
                      ),
                      Icon(Icons.chevron_right,color:Colors.white)
                    ],
                  ),
                ),
              ),
              Container(height: 25,)


        ]));
  }
}
