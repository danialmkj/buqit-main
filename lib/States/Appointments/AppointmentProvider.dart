





import 'package:buqit/Models/Appointment/Appointment.dart';
import 'package:buqit/Models/Appointment/HistoryAppointment.dart';
import 'package:buqit/Models/Appointment/RequestAppointment.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/States/Appointments/data.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';



class AppointmentProvider extends ChangeNotifier{





  List<Appointment> _requests=[];
  List<Appointment> get requests=> _requests;

  List<Appointment> _upcomings=[];
  List<Appointment> get upcomings=> _upcomings;

  List<Appointment> _history=[];
  List<Appointment> get history=> _history;

  List<Appointment> _ongoing=[];
  List<Appointment> get ongoings=> _ongoing;



  // List<WorkingTime> _workingTimes=[];
  // List<WorkingTime> get workingTimes  => _workingTimes;
  //
  // List<Service> _workerService=[];
  // List<Service> get services=> _workerService;
  //
  // bool _gettingTimeLoading=false;
  // bool get gettingTimeLoading=>_gettingTimeLoading;



  Future getAppointments(BuildContext context,AppointmentType type){

    String? userId=Provider.of<AuthProvider>(context,listen: false).id;

    return Dia.get(context, Api.GET_APPOINTMENTS(userId!,type.name.toLowerCase()),

        onSuccess: (res)async{

          var data=res.data;

          switch(type){
            case AppointmentType.Upcoming:

              _upcomings=[...Appointment.toList(data, type)];
              break;

            case AppointmentType.Requests:

              _requests=[...Appointment.toList(data,type)];
              break;

            case AppointmentType.Ongoing:

              _ongoing=[...Appointment.toList(data, type)];
              break;

            case AppointmentType.History:

              _history=[...Appointment.toList(data,type)];
              break;
          }

          notifyListeners();

        },onError: (e){});
  }

  List<Appointment> getAppointmentByType(AppointmentType type) {
    switch(type){
      case AppointmentType.Upcoming:
        return _upcomings;
      case AppointmentType.Requests:
        return _requests;
      case AppointmentType.History:
        return _history;
      case AppointmentType.Ongoing:
        return _ongoing;
    }
  }

  Future cancelRequest(context,{required Function onSuccess,required AppointmentType type,required String appointmentId}){

    String url='';

    switch(type){

      case AppointmentType.Upcoming:
       url=Api.UPCOMING_CANCEL(appointmentId);
        break;
      case AppointmentType.Requests:
        url=Api.REQUEST_CANCEL(appointmentId);
        break;
      case AppointmentType.History:
        url=Api.HISTORY_CANCEL(appointmentId);
        break;
      case AppointmentType.Ongoing:
        url=Api.ONGOING_CANCEL(appointmentId);
        break;
    }
    
    return Dia.patch(context, url).then((res){
      onSuccess(res);


    }).catchError((e){

    });
  }



}