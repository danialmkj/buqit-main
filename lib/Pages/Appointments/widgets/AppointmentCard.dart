import 'package:buqit/Models/Appointment/Appointment.dart';
import 'package:buqit/Widgets/Typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppointmentCard extends HookWidget{

  Appointment appointment;

  @override
  Widget build(BuildContext context) {


    return Container(
      child: Typo(text:appointment.id),
    );
  }

  AppointmentCard({
    required this.appointment,
  });
}