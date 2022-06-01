
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class SplashTouch extends HookWidget {


  Widget? child;
  Color? color;
  Color splashColor;
  String? title;
  double? round;
  Function? onTap;
  EdgeInsets? padding;
  double shadow;
  SplashTouch({this.child,this.title,this.color,this.round,this.onTap,this.padding,this.shadow=0,this.splashColor=Colors.blueGrey});

  @override
  Widget build(BuildContext context) {

    useEffect((){

      return (){};
    },[]);

    final state=useState(0);


    useAnimationController(duration: const Duration(seconds: 2));

    return Material(
        elevation: shadow,
        color: color,
        borderRadius:round!=null ? BorderRadius.circular(round!) : null,

        child:InkWell(
            splashColor: splashColor,
            onTap:(){
              onTap!();
            },
            borderRadius: round!=null ? BorderRadius.circular(round!) : null ,

            child:Padding(
                padding:padding ?? EdgeInsets.all(0),
                child: child ?? Typo(text:title ?? ""))
        )
    );
  }
}