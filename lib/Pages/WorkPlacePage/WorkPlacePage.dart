

// ignore_for_file: null_argument_to_non_null_type

import 'dart:async';

import 'package:buqit/Models/Service.dart';
import 'package:buqit/Models/WorkPlace.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/WorkPlacePage/WorkerCard.dart';
import 'package:buqit/States/Workplace/WorkPlaceProvider.dart';
import 'package:buqit/Utils/Location/LocationUtility.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
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


class WorkPlaceDisplay extends HookWidget{




  @override
  Widget build(BuildContext context) {

    Workplace workplace=ModalRoute.of(context)?.settings.arguments as Workplace;


    final markers = useState<Set<Marker>>({});
    final _controller = useState<GoogleMapController?>(null);

    final workers=useState([]);
    // final locationUtil=useState(LocationUtility);
    final selectedService=useState<Service?>(null);

    useEffect((){


    },[selectedService.value]);

    Size size=MediaQuery.of(context).size;




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


                  print(myLatitude);
                  LatLngBounds bound = LatLngBounds(southwest: workPlace, northeast: myLatitude,);


                  Set<Marker> set=Set();
                  Marker marker=LocationUtility.addMarker(workPlace, workplace.name,"");
                  Marker marker2=LocationUtility.addMarker(myLatitude, "Me", "");

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

                String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${workplace.latitude},${workplace.longitude}';

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
                      Icon(Icons.location_pin),SizedBox(width: 10,),Expanded(child: Typo(text: workplace.address,maxLines: 2,)),Icon(Icons.chevron_right)
                    ],
                  )),
            ),
            Expanded(child: Container(

              child: Column(
                children: [

                  ...workers.value.map((worker) => GestureDetector(

                    child: WorkerCard(worker:worker),
                    onTap: (){
                      Navigator.of(context).pushNamed(Pages.worker,arguments: worker);
                    },
                  ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

}