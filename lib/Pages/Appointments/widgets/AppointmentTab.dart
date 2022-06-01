

import 'package:buqit/Models/Appointment/Appointment.dart';
import 'package:buqit/Models/Appointment/RequestAppointment.dart';
import 'package:buqit/Pages/Appointments/widgets/AppointmentCard.dart';
import 'package:buqit/Pages/Appointments/widgets/RequestCard.dart';
import 'package:buqit/States/Appointments/AppointmentProvider.dart';
import 'package:buqit/States/Appointments/data.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';


class AppointmentTab extends HookWidget{


  AppointmentType type;


  @override
  Widget build(BuildContext context) {



    List<Appointment> appointments=Provider.of<AppointmentProvider>(context).getAppointmentByType(type);


    return Container(
      child: Container(

        child: ListView(

          children: [
            ...appointments.map((appointment) => RequestCard(appointment: appointment))
          ],
        ),
      ),
    );
  }

  AppointmentTab({
    required this.type,
  });
}