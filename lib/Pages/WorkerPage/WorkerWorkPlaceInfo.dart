

// ignore_for_file: null_argument_to_non_null_type

import 'dart:async';

import 'package:buqit/Models/Profile/Setting.dart';
import 'package:buqit/Models/Service.dart';
import 'package:buqit/Models/WorkPlace.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Models/WorkingDay.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/WorkPlacePage/WorkerCard.dart';
import 'package:buqit/Pages/WorkerPage/widgets/WorkDaySection.dart';
import 'package:buqit/States/Workplace/WorkPlaceProvider.dart';
import 'package:buqit/Utils/Location/LocationUtility.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';



void check(CameraUpdate u, GoogleMapController c) async {
  c.animateCamera(u);
  c.animateCamera(u);
  LatLngBounds l1=await c.getVisibleRegion();
  LatLngBounds l2=await c.getVisibleRegion();
  print(l1.toString());
  print(l2.toString());
  if(l1.southwest.latitude==-90 ||l2.southwest.latitude==-90)
    check(u, c);
}

Marker addMarker(LatLng mLatLng, String mTitle, String mDescription){

  return Marker(

    // This marker id can be anything that uniquely identifies each marker.
    markerId: MarkerId(mTitle),
    position: mLatLng,

    infoWindow: InfoWindow(
      title: mTitle,
    ),
    icon: BitmapDescriptor.defaultMarker,
  );
}

class WorkerWorkPlaceInfo extends HookWidget{




  @override
  Widget build(BuildContext context) {

    Worker worker=ModalRoute.of(context)?.settings.arguments as Worker;

    Workplace workplace=worker.workplace;


    final markers = useState<Set<Marker>>({});
    final _controller = useState<GoogleMapController?>(null);

    final workers=useState([]);
    final selectedService=useState<Service?>(null);

    useEffect((){


    },[selectedService.value]);

    Size size=MediaQuery.of(context).size;


    String todayDayOfWeek=DateFormat('EEEE').format(DateTime.now()).toLowerCase();

    _toMap(){
      Map<String,dynamic> map={};

      map["saturday"]=worker.workingPlan?.saturday;
      map["sunday"]=worker.workingPlan?.sunday;
      map["monday"]=worker.workingPlan?.monday;
      map["tuesday"]=worker.workingPlan?.tuesday;
      map["wednesday"]=worker.workingPlan?.wednesday;
      map["thursday"]=worker.workingPlan?.thursday;
      map["friday"]=worker.workingPlan?.friday;



      return map;

    }


    print(todayDayOfWeek);

    useEffect((){
          ()async{
        var data=await Provider.of<WorkPlaceProvider>(context,listen: false).getProviders(context,workplace.id);


        workers.value=[...Worker.toList(data.data)];
      }();
    },[]);





    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(title: workplace.name,color:Colors.black),
      body: Container(
        height: size.height*0.7,
        width: size.width,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: GoogleMap(

                    markers: markers.value,
                    myLocationEnabled: false,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller)async {

                      _controller.value=controller;
                      LatLng workPlace = LatLng(workplace.latitude ,workplace.longitude);
                      Position position = await LocationUtility.determinePosition();
                      LatLng myLatitude = LatLng(position.latitude, position.longitude);

                      LatLngBounds bound = LatLngBounds(southwest: workPlace, northeast: myLatitude);


                      Set<Marker> set=Set();
                      var marker=addMarker(workPlace, workplace.name,"");
                      var marker2=addMarker(myLatitude, "Me", "");

                      set.add(marker);
                      set.add(marker2);

                      markers.value=set;

                      CameraUpdate u2 = CameraUpdate.newLatLngBounds(bound, 50);
                      _controller.value?.animateCamera(u2).then((void v){
                        check(u2,_controller.value!);
                      });
                      // _controller.value.complete(controller);
                    }, initialCameraPosition: const CameraPosition(
                    target:  LatLng(45.521563, -122.677433),
                    zoom: 11.0,
                  ),
                  ),
                )),
            GestureDetector(
              onTap: ()async{
                String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${worker.workplace.latitude},${worker.workplace.longitude}';
                if (await canLaunch(googleUrl)) {
                  await launch(googleUrl);
                } else {
                  throw 'Could not open the map.';
                }

              },
              child: Container(

                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5,color:Colors.grey))
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),

                  // height: 80,
                  child: Row(
                    children: [
                      Icon(Icons.location_pin),SizedBox(width: 10,),Expanded(child: Typo(text: workplace.address,maxLines: 2,size:16)),Icon(Icons.chevron_right)
                    ],
                  )),
            ),

            GestureDetector(
              onTap: (){
                launch("tel://${worker.phone}");
              },
              child: Container(

                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5,color:Colors.grey))
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),

                  // height: 80,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.phone),SizedBox(width: 10,),Expanded(child: Typo(text:worker.phone,maxLines: 2,size:16)),Icon(Icons.chevron_right)
                    ],
                  )),
            ),

            Expanded(child: Container(

              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Column(
                children: [



                  ..._toMap().entries.map((e){


                    if(e.value!=null){
                      bool isToday=e.key==todayDayOfWeek;
                      return  Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(isToday)Container(width:20,height:20, child: Icon(CupertinoIcons.timer_fill)),
                                if(!isToday)Container(width:20,height:20,),
                                SizedBox(width: 7,),
                                Typo(text: e.key.toUpperCase(),bold:e.key==todayDayOfWeek,size:isToday ? 16 : 14),

                              ],),
                            WorkDaySection(isToday:isToday,day: (e.value as WorkingDay),),
                          ],
                        ),
                      );
                    }else{
                      return Container();
                    }


                  })



                  // ...worker.workingPlan.value.map((worker) => GestureDetector(
                  //
                  //   child: WorkerCard(worker:worker),
                  //   onTap: (){
                  //     Navigator.of(context).pushNamed(Pages.worker,arguments: worker);
                  //   },
                  // ))

                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

}