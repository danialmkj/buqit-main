
import 'package:buqit/Models/WorkingDay.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WorkDaySection extends HookWidget{

  bool isToday;
  WorkingDay? day;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           // Typo(text: ),
           // Typo(text:day.toString()),

         ],),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Typo(size:isToday ? 16 : 14,bold:isToday,text: day!.start),
            Typo(text: " - "),
            Typo(size:isToday ? 16 : 14,bold:isToday,text: day!.end),

          ],)
        ],
      ),
    );
  }

  WorkDaySection({
    required this.isToday,
    required this.day,
  });
}