


import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/WorkPlacePage/WorkerCard.dart';
import 'package:buqit/States/Worker/WorkerProvider.dart';
import 'package:buqit/Widgets/DebounceSearch.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/src/provider.dart';

class SmartViewBottomSheet extends HookWidget{


  Function onTap;

  @override
  Widget build(BuildContext context) {


    final searchTextController=useTextEditingController();


    final loading=useState(false);

    return Builder(
      builder: (context){

        List<Worker> workers=context.select((WorkerProvider value) => value.nearbyProviders);


        return Container(

          // height: MediaQuery.of(context).size.height*0.9,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: 80,
                  height: 4,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                  child: Typo(text:"Nearby Providers(${workers.length})",bold: true,size:19)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                child: DebounceField(
                  // hint:"Search by name or workplace",
                  hint:"Search by name",
                  controller: searchTextController,
                  onDebounce: (text){

                  },
                )
              ),
              // SizedBox(height: 20,),
              Expanded(

                  child:ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ...workers.map((worker) => InkWell(
                          onTap: (){

                            Navigator.of(context).pushNamed(Pages.worker,arguments: worker);
                          },
                          child: WorkerCard(worker: worker,details:true)))
                    ],
                  )
              )

            ],
          ),
        );
      },
    );
  }

  SmartViewBottomSheet({
    required this.onTap,
  });
}