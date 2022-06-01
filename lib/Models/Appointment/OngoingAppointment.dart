//
//
// import 'package:buqit/Models/Appointment/Appointment.dart';
// import 'package:buqit/Models/Appointment/Customer.dart';
// import 'package:buqit/Models/Payment/Payment.dart';
// import 'package:buqit/Models/Worker.dart';
// import 'package:buqit/Pages/Appointments/widgets/AppointmentCard.dart';
// import 'package:buqit/States/Appointments/data.dart';
//
// import 'AppointmentService.dart';
//
// class OngoingAppointment extends Appointment{
//
//
//
//
//
//   OngoingAppointment(
//       {
//          required this.book,
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
//   static OngoingAppointment fromMap(Map<String, dynamic> map) {
//     return OngoingAppointment(
//       type:AppointmentType.History,
//       id: map['id'] as String,
//       start: DateTime.parse(map['start']),
//       end: DateTime.parse(map['end']),
//       book: DateTime.parse(map['book']),
//       cardPayment: map['cardPayment'] as bool,
//       code: map['code'],
//       resultCode: map['resultCode'],
//       provider:  Worker.fromMap(map['provider']) ,
//       customer: Customer.fromMap(map['customer'])  ,
//       services: AppointmentService.toList(map['services'] ) ,
//
//     );
//   }
//
//
//   static toList(data){
//     return (data as List).map((map) => OngoingAppointment.fromMap(map)).toList();
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