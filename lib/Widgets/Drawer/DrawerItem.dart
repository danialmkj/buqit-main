



import 'package:buqit/Models/Drawer/DrawerItemModel.dart';
import 'package:buqit/States/Drawer/DrawerProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../Typo.dart';




Map<String,String> titles={
  "MENU_ITEM_APPOINTMENTS":'Appointments',
  "MENU_ITEM_FAVORITES":'Favorites',
  "MENU_ITEM_PAYMENT":'Payment',
  "MENU_ITEM_DISCOUNTS":'Discounts',
  "MENU_ITEM_SUPPORT":'Support',
  "MENU_ITEM_ABOUT":'About',
  "MENU_ITEM_SETTINGS":'Settings',
};

class DrawerItem extends HookWidget {

  DrawerItemModel drawerItem;

  DrawerItem({required this.drawerItem});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return () {};
    }, []);

    Map<String,dynamic> icons=Provider.of<DrawerProvider>(context,listen: false).icons;


    useAnimationController(duration: const Duration(seconds: 2));



    return Material(
      child: InkWell(
          onTap:(){
            // print(drawerItem.id);
            Navigator.of(context).pushNamed(drawerItem.id);
          },
          child:Stack(
            children: [
              Container(

                // margin: EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                decoration: BoxDecoration(
                    // color: Colour.lightGrey
                  // border: Border(bottom: BorderSide(width: 0.3, color: Colors.green))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(icons[drawerItem.id]),
                    SizedBox(width: 15,),
                    Expanded(child: Typo(text: titles[drawerItem.id]!, size: 16,bold:true)),
                    Icon(Icons.chevron_right)



                  ],
                ),
              ),
              // if(selected)Positioned(
              //   left:0,
              //   top:8,
              //   bottom:8,
              //   child:Container(
              //     decoration: BoxDecoration(
              //         color:Colour.primaryBlue,
              //         borderRadius: BorderRadius.circular(50)
              //     ),
              //     width: 6,
              //
              //
              //   ) ,
              // )
            ],
          )
      ),
    );
  }
}
