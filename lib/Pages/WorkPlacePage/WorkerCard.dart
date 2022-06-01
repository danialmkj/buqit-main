import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Utils/Location/LocationUtility.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WorkerCard extends HookWidget{

  Worker worker;
  bool details;

  @override
  Widget build(BuildContext context) {



    final distance=useState(0.0);

    useEffect((){
      ()async{
        distance.value=await LocationUtility.distanceFromMe(worker.workplace.latitude, worker.workplace.longitude);
      }();
    },[]);

    print(distance.value);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5,color:Colors.grey))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(worker.photoUrl,width: 60,height: 60,fit:BoxFit.cover),
                    ),
                  ),
                  Positioned(
                      bottom:0,right:0,
                      child: Icon(Icons.check,color:Colors.green))
                ],
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Typo(text: worker.firstName + worker.lastName,size: 16,bold:true),
                  SizedBox(height: 5,),
                  if(!details)Row(

                    children: [
                      Typo(text: worker.rating.toString()),
                      SizedBox(width: 10,),
                      RatingBar.builder(
                        initialRating: worker.rating,
                        minRating: 1,
                        maxRating: 5,
                        itemSize: 20,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,

                        ), onRatingUpdate: (double value) {  },

                      ),

                  ],),
                  if(details) Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.timer_fill),
                          const SizedBox(width: 5,),
                          Typo(text: "${distance.value.toStringAsFixed(1)} m away"),

                        ],
                      ),
                      SizedBox(width: 30,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(CupertinoIcons.briefcase_fill),
                          const SizedBox(width: 5,),
                          Typo(text: worker.workplace.name),

                        ],
                      ),
                    ],
                  ),
                  if(details)SizedBox(height: 5,),
                  if(details)Container(
                      width: MediaQuery.of(context).size.width*0.65,
                      child: Typo(text: worker.workplace.address,maxLines: 1,color:Colors.grey))
                ],
              ),
            ],
          ),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }

  WorkerCard({
    required this.worker,
     this.details=false,
  });
}