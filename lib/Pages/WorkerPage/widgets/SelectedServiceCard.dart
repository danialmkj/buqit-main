
import 'package:buqit/Models/Service.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';




class SelectedServiceCard extends HookWidget{

  Service service;
  bool selected;


  String renderDuration(int duration){
    int hour=duration~/60;
    int minute=duration%60;


    return ((hour!=0 ? "$hour hour, " : "") + (minute!=0 ? "$minute minutes" : ""));

  }

  @override
  Widget build(BuildContext context) {


    return Container(

      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),

      decoration:  BoxDecoration(
        color:selected  ? Colors.blueAccent.withOpacity(0.2) : Theme.of(context).canvasColor,
          border: const Border(bottom: BorderSide(width: 0.4,color: Colors.grey))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: 55,
                height: 55,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(service.photos[0].url,width: 70,height: 70,fit: BoxFit.cover,)),
                    if(selected)Positioned(bottom:0,right:0,child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                          color:Colors.green
                      ),
                      padding:EdgeInsets.all(1),child: Icon(Icons.check,size:20,color:Colors.white))),
                  ],
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Typo(text: service.name,bold:true,size:15),
                  const SizedBox(height: 5,),
                  Typo(text: renderDuration(service.duration),color: Colors.grey,),


                ],
              ),
            ],
          ),
          Row(
            children: [

              // const SizedBox(height: 5,),
              Typo(text: "R${service.price.toStringAsFixed(2)}",bold:true,size: 16,),
            ],
          ),

        ],
      ),
    );
  }

  SelectedServiceCard({
    required this.service,
     this.selected=false,
  });
}