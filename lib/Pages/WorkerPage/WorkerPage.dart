

import 'package:buqit/Models/Service.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/WorkerPage/WorkerAvailabilitySheet.dart';
import 'package:buqit/Pages/WorkerPage/widgets/IconButton.dart';
import 'package:buqit/Pages/WorkerPage/widgets/ServiceCard.dart';
import 'package:buqit/States/Worker/WorkerProvider.dart';
import 'package:buqit/States/Workplace/WorkPlaceProvider.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class WorkerPage extends HookWidget{


  @override
  Widget build(BuildContext context) {

    Worker worker =ModalRoute.of(context)?.settings.arguments as Worker;


    final favoriteStatus=useState(false);
    final services=useState< Map<String,List<Service>>>({});
    final selectedService=useState<Service?>(null);


    void showAsBottomSheet(Service service) async {
      final result = await showSlidingBottomSheet(
          context,
          builder: (context) {
            return SlidingSheetDialog(


              // extendBody: true,
              elevation: 8,
              cornerRadius: 16,
              snapSpec: const SnapSpec(
                snap: true,
                initialSnap: 0.9,
                snappings: [0.0, 0.7, 0.9],
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              builder: (context, state) {
                return WorkerAvailabilitySheet(selectedService: selectedService.value,worker: worker,);
              },
            );
          }
      );

      selectedService.value=null;
      // This is the result.
    }

    useEffect((){
      if(selectedService.value!=null){
        Future.delayed(const Duration(milliseconds: 10),(){
          showAsBottomSheet(selectedService.value!);
        });
      }

    },[selectedService.value]);






    _getData()async{

      // var data=Future.wait([
      //   Provider.of<WorkPlaceProvider>(context,listen: false).getWorkerService(context,worker.id),
      //   Provider.of<WorkerProvider>(context,listen: false).chekWorkerFavourite(context,worker.id)
      // ]);
      var data=await Provider.of<WorkerProvider>(context,listen: false).getWorkerService(context,worker.id);

      // print(status);

      // favoriteStatus.value=status;

      Map<String,List<Service>> map={};
      Service.toList(data.data).forEach((service) {
        String category=service.category.name;
        if(map.containsKey(service.category.name)){
          map[category]?.add(service);
        }else{
          map[category]=[];
        }
      });

      services.value=map;
    }


    useEffect((){
      _getData();
    },[]);




    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        title: worker.firstName + worker.lastName,
        actions: [ FavouriteToggleIcon(workerId: worker.id,)],
      ),
      body: SafeArea(
        child: Container(
          child:Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  border: Border(bottom:BorderSide(width: 0.3,color:Colors.grey))
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
                            Row(children: [
                              Typo(text: worker.rating.toString()) ,
                              SizedBox(width: 10,),
                              RatingBar.builder(
                                initialRating: worker.rating,
                                minRating: 1,
                                maxRating: 5,
                                itemSize: 20,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => Icon(

                                  Icons.star,
                                  color: Colors.amber,

                                ), onRatingUpdate: (double value) {  },

                              )
                            ],)
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              Container(

                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5,color:Colors.grey))
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                  // height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Typo(text: "Workplace info",bold:true,size:15,),
                      SizedBox(height: 5,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.location_pin),
                          SizedBox(width: 10,),
                          Expanded(child: Typo(text: worker.workplace.address,maxLines: 2,)),
                          SizedBox(width: 10,),
                          GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed(Pages.workerWorkPlaceInfo,arguments:worker);
                              },
                              child: Typo(text: "More info",bold:true,size:17,color: Colors.blueAccent,))
                        ],
                      ),
                    ],
                  )),
              Expanded(
                child: ListView(
                  children: [

                    ...services.value.entries.where((map) => map.value.isNotEmpty).map((e){

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        // padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Container(

                                child: Typo(text: e.key,bold:true,size:18,color:Colour.primaryBlue),
                                padding: EdgeInsets.only(left:10),
                            ),
                            ...e.value.map((service) => ServiceCard(service: service,onTap: (){
                              selectedService.value=service;

                            },))
                          ],
                        ),
                      );
                    })

                  ]
                  ,
                ),
              )
            ],
          )
        ),
      ),
    );
  }

}

