//
//
// import 'package:buqit/Models/Appointment/Appointment.dart';
// import 'package:buqit/Models/Appointment/Customer.dart';
// import 'package:buqit/Models/Worker.dart';
// import 'package:buqit/Pages/Appointments/widgets/AppointmentCard.dart';
// import 'package:buqit/States/Appointments/data.dart';
//
// import 'AppointmentService.dart';
//
// class RequestAppointment extends Appointment{
//
//   bool accepted;
//
//   RequestAppointment(
//       {
//         required this.accepted,
//         type,
//         id,
//         start,
//         end,
//         cardPayment,
//         provider,
//         customer,
//         services,
//       }
//       ) : super(
//     type:type,
//     id:id,
//     end: end,
//     start: start,
//     cardPayment: cardPayment,
//     provider: provider,
//     customer: customer,
//     services: services,
//   );
//
//
//   static RequestAppointment fromMap(Map<String, dynamic> map) {
//     return RequestAppointment(
//       type:AppointmentType.Requests,
//       id: map['id'] as String,
//       start: DateTime.parse(map['start']),
//       end: DateTime.parse(map['end']),
//       cardPayment: map['cardPayment'] as bool,
//       accepted: map['accepted'] as bool,
//       provider:  Worker.fromMap(map['provider']) ,
//       customer: Customer.fromMap(map['customer'])  ,
//       services: AppointmentService.toList(map['services'] ) ,
//     );
//   }
//
//
//   static toList(data){
//     return (data as List).map((map) => RequestAppointment.fromMap(map)).toList();
//   }
//
//
//
//
//
//
//
//
//
// }