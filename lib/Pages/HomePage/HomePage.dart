

import 'dart:async';

import 'package:buqit/Models/SearchHistory.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Pages/HomePage/widgets/SmartViewBottomSheet.dart';
import 'package:buqit/States/Drawer/DrawerProvider.dart';
import 'package:buqit/States/Worker/WorkerProvider.dart';
import 'package:buqit/States/Workplace/WorkPlaceProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Utils/Location/LocationUtility.dart';
import 'package:buqit/Widgets/Buttons/SplashTouch.dart';
import 'package:buqit/Widgets/Drawer/Drawerax.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/src/transformers/backpressure/debounce.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../Pages.dart';

class HomePage extends HookWidget{




  void _setCameraPosition(positionNotifier)async{


    Position position = await LocationUtility.determinePosition();


    positionNotifier.value=CameraPosition(
      target: LatLng(position.latitude, position.longitude), zoom: 14.4746,
    );


  }

  ValueNotifier<bool> nearbyLoading=ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {


    final _controller = useState<GoogleMapController?>(null);




    final markers = useState<Set<Marker>>({});
    final cameraPosition=useState<CameraPosition?>(null);
    final cameraPositionController=useStreamController<CameraPosition>();



    // ignore: missing_return
    useEffect((){
      cameraPositionController.stream.debounceTime(const Duration(milliseconds: 1500)).listen((position) {


        nearbyLoading.value=true;

        Provider.of<WorkerProvider>(context,listen: false).getNearbyWorkers(
            context,
            latLng: LatLng(position.target.latitude,position.target.longitude),
            onSuccess:(List<Worker> workers){

              Set<Marker> markerSet={};
              workers.forEach((worker) {
                Marker marker=LocationUtility.addMarker(LatLng(worker.workplace.latitude, worker.workplace.longitude), worker.firstName, "mDescription");
                markerSet.add(marker);
              });

              markers.value=markerSet;
              nearbyLoading.value=false;
            },
          onError:(e){
            nearbyLoading.value=false;
          }
        );

      });


    },[]);


    //
    // useEffect((){
    //   print(cameraPosition.value);
    //
    // },[cameraPosition.value]);





    useEffect((){
      _setCameraPosition(cameraPosition);

      Provider.of<WorkPlaceProvider>(context,listen: false).getSearchHistory(context);
    },[]);

    https://www.facebook.com/buqit_app
    https://www.instagram.com/buqitapp
    https://www.twitter.com/buqitapp
    https://buqit.com/careers
    https://buqit.com/terms-and-conditions

    if(cameraPosition.value==null){

      return CupertinoActivityIndicator();
    }else{

      return Scaffold(
        drawer: Drawerax(),
        body: SlidingSheet(

          extendBody: true,
          headerBuilder: (ctx,s){
            return Container(
              margin: const EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                  color:Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)
              ),
              width: 60,height: 5,);
          },
          elevation: 2,
          cornerRadius: 16,
          snapSpec: const SnapSpec(
            snap: true,
            initialSnap: 1,
            snappings: [0.8, 1],
            positioning: SnapPositioning.relativeToSheetHeight,
          ),
          body: Container(

            child: Stack(
              children: [
                Positioned(
                  top:0,left:0,right:0,
                  bottom:0,
                  child: GoogleMap(

                    onCameraMove: (c){
                      cameraPositionController.add(c);
                    },
                    markers: markers.value,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition:cameraPosition.value!,
                    onMapCreated: (GoogleMapController controller) {

                      _controller.value=controller;
                    },
                  ),
                ),
                // Positioned(
                //     top:MediaQuery.of(context).size.height-200,
                //     right:0,left:0,bottom:0,
                //     child: Builder(
                //         builder: (context) {
                //
                //           List<SearchHistory> searchHistories=context.watch<WorkPlaceProvider>().searchHistory;
                //
                //           return Container(
                //
                //             // padding: EdgeInsets.symmetric(horizontal: 5),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Container(height: 15,),
                //                 GestureDetector(
                //                   onTap:(){
                //                     Navigator.of(context).pushNamed(Pages.search,arguments: null);
                //                   },
                //
                //                   child: Container(
                //                     padding: EdgeInsets.all(11),
                //                     margin: EdgeInsets.only(left: 15,right:15,top: 10,bottom:0),
                //
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(5),
                //                       color: Colors.grey.shade400,
                //                     ),
                //                     child: Row(
                //                       children: [
                //                         Icon(Icons.search),
                //                         SizedBox(width: 5,),
                //                         Typo(text: "What are you getting done ?",bold:true,)
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 ...searchHistories.map((SearchHistory item){
                //                   return GestureDetector(
                //                     onTap: (){
                //                       Navigator.of(context).pushNamed(Pages.search,arguments: item);
                //                     },
                //                     child: Container(
                //                       padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                //                       margin: EdgeInsets.symmetric(horizontal: 10),
                //                       decoration: BoxDecoration(
                //                           border: Border(bottom:BorderSide(width: 0.3,color:Colors.grey))
                //                       ),
                //                       // margin: EdgeInsets.symmetric(horizontal: 20),
                //                       child: Row(
                //                         children: [
                //                           item.type!='workplace' ? Icon(CupertinoIcons.tag,color: Colors.grey) : Icon(CupertinoIcons.home,color: Colors.grey,),
                //                           SizedBox(width: 10,),
                //                           Typo(text:item.content,size: 17,),
                //                         ],
                //                       ),
                //                     ),
                //                   );
                //                 })
                //               ],
                //             ),);
                //         }
                //     )),
                Builder(
                    builder: (context) {

                      bool loading=context.read<DrawerProvider>().loading;


                      return Positioned(top:40,left:30,child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),

                        child: loading ? CupertinoActivityIndicator() :SplashTouch(

                          color: Colors.white,
                          round: 50,
                          shadow: 3,
                          padding: EdgeInsets.all(10),
                          child:Icon(Icons.menu,color:Colors.black),
                          onTap: (){
                            Scaffold.of(context).openDrawer();

                          },),
                      ));
                    }
                ),
                Positioned(
                    top:40,right:30,
                  child: Row(
                    children: [
                      Builder(
                          builder: (context) {

                            List<Worker> workers=context.read<WorkerProvider>().nearbyProviders;

                            if(workers.isNotEmpty){

                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),

                              child:SplashTouch(

                                  color: Colors.white,
                                  shadow: 3,
                                  padding: EdgeInsets.all(10),
                                  round: 50,

                                  onTap: (){
                                    showModalBottomSheet(context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        builder: (context){

                                          return SmartViewBottomSheet(onTap:(){},);
                                        });


                                  },child: Row(
                                children: [
                                  const Icon(Icons.location_history,color:Colors.black),
                                  const SizedBox(width: 10,),
                                  Typo(text: "Smart View",color: Colors.black,bold:true)
                                ],
                              )),
                            );
                            }

                            return Container();


                          }
                      ),
                      const SizedBox(width: 10,),
                      SplashTouch(
                        onTap: ()async{
                          Position pos=await LocationUtility.determinePosition();

                          _controller.value?.moveCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(pos.latitude,pos.longitude),
                                zoom: 16
                                // bearing: location.heading,
                                // zoom: _zoom,
                                // tilt: _tilt,
                              ))
                          );

                        },
                        round: 50,
                        color: Colour.primaryBlue,
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.my_location,color:Colors.white),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(valueListenable: nearbyLoading, builder: (BuildContext context, bool value, Widget? child) {


                  if(value){
                    return  const Positioned(
                        top:100,
                        left:0,right:0,
                        child: CupertinoActivityIndicator(radius: 18,));
                  }else{
                    return Container();
                  }

                },),
              ],
            ),

          ),
          builder: (ctx,state){

            return Builder(
                builder: (context) {

                  List<SearchHistory> searchHistories=context.watch<WorkPlaceProvider>().searchHistory;

                  return Container(
                    // height: 300,

                    // padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(height: 10,),
                        GestureDetector(
                          onTap:(){
                            Navigator.of(context).pushNamed(Pages.search,arguments: null);
                          },

                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                            margin: EdgeInsets.only(left: 15,right:15,top: 10,bottom:0),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.shade200,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search,color:Colors.black),
                                SizedBox(width: 5,),
                                Typo(text: "What are you getting done ?",bold:true,size:16,color:Colors.black)
                              ],
                            ),
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: [
                            ...searchHistories.map((SearchHistory item){
                              return InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed(Pages.search,arguments: item);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom:BorderSide(width: 0.3,color:Colors.grey))
                                  ),
                                  // margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      item.type!='workplace' ? Icon(CupertinoIcons.tag,size:23,color: Colors.grey,) : Icon(Icons.location_city,size:25,color: Colors.grey,),
                                      SizedBox(width: 10,),
                                      Typo(text:item.content,size: 17,),
                                    ],
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                        Container(height: 20,),
                      ],
                    ),);
                }
            );
          }
        ),
      );
    }


  }

}