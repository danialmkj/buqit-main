
import 'package:buqit/Models/Service.dart';
import 'package:buqit/Pages/WorkerPage/AddServicePage/widgets/ServiceSection.dart';
import 'package:buqit/States/Worker/WorkerProvider.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class AddServicePage extends HookWidget{

  @override
  Widget build(BuildContext context) {



    var passedServices =ModalRoute.of(context)?.settings.arguments as List;

    final selectedService=useState<List<Service>>([...passedServices]);


    // final rawServices=useState([...Provider.of<WorkerProvider>(context,listen: false).services]);

    final Map<String,List<Service>> groupedServices=Provider.of<WorkerProvider>(context,listen: false).getGroupedServices(context);
    final tabController=useTabController(initialLength: groupedServices.entries.where((mappedItem) => mappedItem.value.isNotEmpty).length,initialIndex:0 );



    print(selectedService.value);


   return Scaffold(

     body: SafeArea(
       child: Stack(
         children: [

           Container(
             child: Container(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 10),
                     child: Row(
                       // mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         GestureDetector(
                           onTap: (){
                             Navigator.of(context).pop(null);
                           },
                           child: Icon(Icons.chevron_left,size: 30,),
                         ),
                         SizedBox(width: 10,),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Typo(text: "Services",bold: true,size: 17,),
                             Typo(text: "${selectedService.value.length} Service Selected")
                           ],
                         )


                       ],
                     ),
                   ),
                   SizedBox(height: 10,),
                   TabBar(


                     labelColor:Theme.of(context).textTheme.subtitle1?.color,
                     unselectedLabelColor:Theme.of(context).textTheme.subtitle1?.color?.withOpacity(0.3),
                     onTap: (index){

                     },
                     isScrollable: true,
                     controller: tabController,
                     tabs: groupedServices.entries.where((mappedItem) => mappedItem.value.isNotEmpty).map((map) => Container(
                         padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                         child: Typo(text: map.key.toUpperCase(),))).toList(),
                   ),
                   Expanded(child: TabBarView(
                     controller: tabController,
                     children: [
                            ...groupedServices.entries.where((mappedItem) => mappedItem.value.isNotEmpty).map((map) =>ServiceSection(
                                selectedServices:selectedService.value,
                                services: map.value,
                                onSelect: (service){

                                    if(!selectedService.value.map((service)=>service.id).contains(service.id)){
                                      List<Service> newServices=[...selectedService.value];
                                      newServices.add(service);
                                      selectedService.value=newServices;
                                    }else{
                                      List<Service> newServices=[...selectedService.value];
                                      newServices.removeWhere((element) => element.id==service.id);
                                      selectedService.value=newServices;
                                    }
                                }))
                     ],

                   ))
                 ],
               ),
             )
           ),
           Positioned(
               bottom:10,right:10,
               child: GestureDetector(
                 onTap: (){
                   print("hara");
                   Navigator.of(context).pop(selectedService.value);
                 },
                 child: Container(
                     decoration:  BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(50),
                         boxShadow:  [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.1),
                             blurRadius: 4,
                             spreadRadius: 6,
                           )
                         ]
                     ),
                     padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                     child: Row(children: [Icon(Icons.check),SizedBox(width: 10,),Typo(text:"Add")])
                 ),
               )
           ),
         ],
       ),
     ),
   );
  }

}