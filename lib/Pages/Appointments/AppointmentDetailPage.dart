

import 'package:buqit/Models/Appointment/Appointment.dart';
import 'package:buqit/Pages/Appointments/widgets/AppointmentServiceCard.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/WorkerPage/widgets/ServiceCard.dart';
import 'package:buqit/States/Appointments/AppointmentProvider.dart';
import 'package:buqit/States/Appointments/data.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Utils/DateUtility.dart';
import 'package:buqit/Widgets/Appbar/CustomAppbar.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AppointmentDetailPage extends HookWidget{





  @override
  Widget build(BuildContext context) {

    var appointment=ModalRoute.of(context)?.settings.arguments as Appointment;

    return Scaffold(
      appBar: CustomAppbar(title: "Appointment Details",),
      body: Container(
        child:ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 6,
                  )
                ],
              ),
              // color: Colors.red,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      decoration: BoxDecoration(
                          border:Border(bottom: BorderSide(width: 0.4,color:Colors.grey))
                      ),
                      child:Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 20,top: 10,bottom: 10),
                            decoration: BoxDecoration(
                                border:Border(right: BorderSide(width: 0.4,color:Colors.grey))
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Typo(text: appointment.start.day.toString(),color: Colour.primaryBlue,size:20,bold:true),
                                  Typo(text: DateUtility(dateTime:appointment.start ).monthAbbreviation(),size:20,bold:true),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Center(child: Typo(bold:true,size:24,text:"${DateUtility(dateTime: appointment.start).renderTime()} - ${DateUtility(dateTime: appointment.end).renderTime()}")),
                          )
                        ],
                      )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    decoration: BoxDecoration(
                        border:Border(bottom: BorderSide(width: 0.4,color:Colors.grey))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Typo(text: "Address",color: Colors.grey,),
                        SizedBox(height: 2,),
                        Typo(text: appointment.provider.workplace.address,color: Colors.grey,maxLines: 3,),
                      ],
                    ),
                  ),


                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(Pages.worker,arguments: appointment.provider);
                    },
                    child: Container(
                      color: Theme.of(context).cardColor,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      // decoration: BoxDecoration(
                      //     border:Border(bottom: BorderSide(width: 0.4,color:Colors.grey))
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Typo(text: "View Provider",size:16),
                          SizedBox(height: 2,),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),


            if(appointment.type==AppointmentType.Requests)GestureDetector(
              onTap: (){
                Provider.of<AppointmentProvider>(context,listen: false).cancelRequest(context,type: appointment.type,appointmentId: appointment.id,onSuccess: (res){
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Appointment has been canceled.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                });
              },
              child: Container(


                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow:  [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      spreadRadius: 6,
                    )
                  ],
                ),
                // color: Colors.red,
                child:  Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

                  child: Row(
                    children: [
                      Icon(Icons.close),
                      SizedBox(width: 5,),
                      Typo(text: "Cancel Appointment",size:16),
                    ],
                  ),
                ),
              ),
            ),

            if(appointment.type!=AppointmentType.Requests)Container(


              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 6,
                  )
                ],
              ),
              // color: Colors.red,
              child:  Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Typo(text: "Appointment Code",color:Colors.grey),
                    SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Typo(text:appointment.code.toString(),size:20,bold:true),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(context: context, builder:(ctx){
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                // height: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Typo(text: "Appointment Code",bold:true,size:17),
                                    const SizedBox(height: 20,),
                                    Typo(maxLines: 5,text: "The 4-digit appointment code is used to verify the completion of an appointment. Give this code to the provider at the end of your appointment."),
                                    const SizedBox(height: 20,),
                                    ElevatedButton(

                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50)
                                            ),
                                            primary: Colour.primaryBlue),
                                        onPressed: (){
                                      Navigator.of(context).pop();
                                    }, child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 13),
                                      child: Typo(text:"OK",bold:true,size:16),
                                    ))
                                  ],
                                ),
                              );
                            });
                          },
                          child: Icon(Icons.info_outline),
                        )
                      ],
                    ),

                  ],
                )
              ),
            ),



            SizedBox(height: 30,),


            Padding(
              padding: const EdgeInsets.only(left: 20,top: 20,bottom:10),
              child: Typo(text: "ORDER SUMMARY",color: Colors.grey,size:15,),
            ),


            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 6,
                  )
                ],
              ),
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                      // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      decoration: BoxDecoration(
                          border:Border(bottom: BorderSide(width: 0.4,color:Colors.grey))
                      ),
                      child:Column(
                        children: [
                          ...appointment.services.map((service) => AppointmentServiceCard(service: service, onTap:(){})),

                        ],
                      )
                  ),

                  if(appointment.payment!=null)Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                    decoration: const BoxDecoration(
                        border:Border(bottom: BorderSide(width: 0.4,color:Colors.grey))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Typo(text: "PAYMENT",color:Colors.red),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ignore: unnecessary_null_comparison
                            Row(children: [ const Icon(Icons.payments_outlined),SizedBox(width: 5,),Typo(text:appointment.payment!.last4Digits==null ? "Cash" : '**** ${appointment.payment!.last4Digits}',bold:true,size:15)],),
                            Typo(text:"R${appointment.payment!.amount.toStringAsFixed(2)}" ,bold:true,)


                          ],),



                      ],
                    )
                  ),


                ],
              ),
            ),
          ],

        )
      ),
    );
  }

}