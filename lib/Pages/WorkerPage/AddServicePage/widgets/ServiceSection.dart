
import 'package:buqit/Models/Service.dart';
import 'package:buqit/Pages/WorkerPage/widgets/SelectedServiceCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ServiceSection extends HookWidget{

  List<Service> services;
  List<Service> selectedServices;
  Function onSelect;


  @override
  Widget build(BuildContext context) {


    return Container(
      child:ListView(
        children: [
          ...services.map((service) => InkWell(
              onTap: (){
                print("para");
                onSelect(service);
              },
              // ignore: iterable_contains_unrelated_type
              child: SelectedServiceCard(service: service,selected:selectedServices.map((service)=>service.id).contains(service.id))))
        ],
      ),
    );

  }

  ServiceSection({
    required this.services,
    required this.onSelect,
    required this.selectedServices,
  });
}