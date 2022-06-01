

import 'package:buqit/Models/Service.dart';
import 'package:buqit/Widgets/ImageHandler.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ServiceCard extends HookWidget{

  Service service;
  Function onTap;

  @override
  Widget build(BuildContext context) {


    String renderDuration(int duration){
      int hour=(duration/60).toInt();
      int minute=duration%60;


      return ((hour!=0 ? "$hour hour, " : "") + (minute!=0 ? "$minute minutes" : ""));

    }

    return InkWell(
      onTap: (){onTap();},
      child: Container(

        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),

        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4,color: Colors.grey))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Typo(text: service.name,bold:true,size:15),
                SizedBox(height: 5,),
                Typo(text: renderDuration(service.duration),color: Colors.grey,),
                SizedBox(height: 5,),
                Typo(text: "R${service.price.toStringAsFixed(2)}",bold:true,size: 13,),

              ],
            ),
            ImageHandler(size: 70, url: service.photos[0].url),
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(20),
            //     child: Image.network(service.photos[0].url,width: 70,height: 70,fit: BoxFit.cover,))
          ],
        ),
      ),
    );
  }

  ServiceCard({
    required this.service,
    required this.onTap,
  });
}