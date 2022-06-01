
import 'package:buqit/Models/WorkPlace.dart';
import 'package:buqit/Pages/SearchPage/SearchPage.dart';
import 'package:buqit/Utils/Location/LocationUtility.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';





class WorkPlaceListing extends HookWidget{


  Workplace workplace;


  @override
  Widget build(BuildContext context) {


    final distance=useState(0.0);
    _calculateDistance()async{
      Position position = await LocationUtility.determinePosition();

      distance.value= Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        workplace.latitude,
        workplace.longitude,
      );


    }

    useEffect((){
      _calculateDistance();
    },[]);




    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      padding:EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.2))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Typo(text: workplace.name,bold:true,size:17),
              SizedBox(height: 5,),
              Typo(text: "${distance.value.toStringAsFixed(2)} km away",size:15),
              SizedBox(height: 5,),
              Container(

                  width: MediaQuery.of(context).size.width*0.8,
                  child: Typo(text: workplace.address,size:15,maxLines: 1,)),

            ],
          ),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }

  WorkPlaceListing({
    required this.workplace
  });
}