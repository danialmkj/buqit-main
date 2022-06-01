

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingSection extends StatelessWidget{

  Widget child;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      decoration: BoxDecoration(
        border:Border(bottom:BorderSide(width: 0.4,color: Colors.grey))
      ),

      child: child,
    );
  }

  SettingSection({
    required this.child,
  });

}