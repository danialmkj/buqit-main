
import 'package:buqit/Models/WorkPlace.dart';
import 'package:buqit/Pages/SearchPage/SearchPage.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';



Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


class ServiceListing extends HookWidget{


  String? service;


  @override
  Widget build(BuildContext context) {




    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      padding:EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.2))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(CupertinoIcons.tag_solid,color: Colors.grey.shade400,size: 20,),
              SizedBox(width: 10,),
              Typo(text:service!,bold:true,size:17),


            ],
          ),
          // Icon(Icons.chevron_right)
        ],
      ),
    );
  }

  ServiceListing({
    required this.service
  });
}