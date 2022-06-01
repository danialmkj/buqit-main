

import 'package:buqit/Models/Payment/Payment.dart';
import 'package:buqit/Models/Service.dart';
import 'package:buqit/Models/Appointment/Customer.dart';
import 'package:buqit/Models/Appointment/AppointmentService.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/States/Appointments/data.dart';

class Appointment{
  AppointmentType type;
  String id;
  DateTime start;
  DateTime end;
  Worker provider;
  Customer customer;
  List<AppointmentService> services;
  bool cardPayment;
  bool? accepted;
  Payment? payment;
  int? resultCode;
  int? code;
  DateTime? book;


  // bool accepted;


  Appointment({
    required this.type,
    required this.id,
    this.payment,
    required this.start,
    required this.end,
    required this.cardPayment,
     this.accepted,
    required this.provider,
    required this.customer,
    required this.services,
     this.code,
     this.resultCode,
     this.book,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'start': this.start,
      'end': this.end,
      'cardPayment': this.cardPayment,
      // 'accepted': this.accepted,
      'provider': this.provider,
      'customer': this.customer,
      'services': this.services,
    };
  }

   static Appointment fromMap(Map<String, dynamic> map,AppointmentType type) {
    return Appointment(
      type:type,
      id: map['id'] as String,
      start: DateTime.parse(map['start']),
      end: DateTime.parse(map['end']),
      book: map['book'] !=null ? DateTime.parse(map['book']) : null,
      cardPayment: map['cardPayment'] as bool,
      accepted: map['cardPayment']!=null ? map['cardPayment'] :null,
      payment: map['payment']!=null ? Payment.fromMap(map['payment'] ) as Payment? : null ,
      code: map['code'],
      resultCode: map['resultCode'],
      // accepted: map['accepted'] as bool,
      provider:  Worker.fromMap(map['provider']) ,
      customer: Customer.fromMap(map['customer'])  ,
      services: AppointmentService.toList(map['services'] ) ,
    );
  }


  static toList(data,type){
    return (data as List).map((map) => Appointment.fromMap(map,type)).toList();
  }
}