

import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/States/Drawer/DrawerProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Widgets/Buttons/SplashTouch.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends HookWidget{
  @override
  Widget build(BuildContext context) {




    useEffect((){


      Future.wait([
      Provider.of<AuthProvider>(context,listen: false).init(context),




      ]).then((value){


        if(value[0]){

          Navigator.of(context).pushReplacementNamed(Pages.home);
        }else{
          Navigator.of(context).pushReplacementNamed(Pages.login);
        }




        // showMaterialModalBottomSheet(
        //   // isDismissible: false,
        //   useRootNavigator: true,
        //   context: context,
        //   builder: (context) => Container(
        //     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        //     height: 100,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Typo(text: "Get started with BuQit",color: Colors.black,bold:true,size: 16,),
        //         SizedBox(height: 10,),
        //         // GestureDetector(
        //         //     onTap: (){
        //         //
        //         //     },
        //         //     child: Icon(CupertinoIcons.arrow_right,color:Colors.white)),
        //         Container(
        //
        //
        //           child: SplashTouch(
        //             onTap: (){
        //               print("adasd");
        //               Navigator.of(context).pushNamed(Pages.login);
        //             },
        //             padding: EdgeInsets.all(10),
        //             round: 20,
        //             color: Colour.primaryBlue,
        //             child: Row(
        //
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Expanded(child: Typo(text: "Continue",align: TextAlign.center,bold:true,size:16,color:Colors.white)),
        //               Icon(CupertinoIcons.arrow_right,color:Colors.white)
        //             ],
        //           ),),
        //         )
        //       ],
        //     ),
        //   ),
        // );
      });

    },[]);

    return Scaffold(
      backgroundColor: Colour.primaryBlue,
      body:Container(
        child: Stack(
          children: [


            Container(

              child: Center(
                child: Typo(text:"BuQit",size: 50,color: Colors.white,bold:true),

              ),





            )
          ],
        ),
      ) ,
    );
  }

}