



import 'package:buqit/Models/Appointment/Appointment.dart';
import 'package:buqit/Models/Appointment/RequestAppointment.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/States/Appointments/data.dart';
import 'package:buqit/Utils/Colour.dart';
import 'package:buqit/Utils/DateUtility.dart';
import 'package:buqit/Widgets/Buttons/SplashTouch.dart';
import 'package:buqit/Widgets/ImageHandler.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RequestCard extends HookWidget{

  Appointment appointment;
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).canvasColor,
        boxShadow:  [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 6,
          )
        ],

      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.4,color:Colors.grey))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Typo(text:appointment.provider.firstName + " " + appointment.provider.lastName,bold:true,size:17),
                    const SizedBox(height: 5,),
                    Typo(size:15,color:Colors.grey,text:"${DateUtility(dateTime: appointment.start).renderCardDate()} ${DateUtility(dateTime: appointment.start).renderTime()}-${DateUtility(dateTime: appointment.end).renderTime()}"),
                  ],
                ),
                ImageHandler(size: 70, url: appointment.provider.photoUrl,round: 50,)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(

                onTap: (){

                  Navigator.of(context).pushNamed(Pages.appointmentDetail,arguments: appointment);
                },

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 10),
                  child: Typo(text:"VIEW DETAILS",color: Colour.primaryBlue,bold:true,size:16),
                ),
              ),
              if(appointment.type==AppointmentType.Requests)SplashTouch(
                onTap: (){},
                round: 50,
                color: Colors.transparent,
                padding: EdgeInsets.all(10),
                child: Icon(Icons.phone),

              ),
              if(appointment.type==AppointmentType.History)Typo(text:"FINISHED",color: Colour.primaryBlue,bold:true,size:16),
            ],
          )
        ],
      ),
    );
  }

  RequestCard({
    required this.appointment,
  });
}