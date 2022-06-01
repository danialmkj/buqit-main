





import 'package:buqit/Models/Appointment/Appointment.dart';
import 'package:buqit/Models/Appointment/HistoryAppointment.dart';
import 'package:buqit/Models/Appointment/RequestAppointment.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/States/Appointments/data.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';



class ProfileProvider extends ChangeNotifier{





  // List<Worker> _favoriteWorkers=[];
  // List<Worker> get favoriteWorkers=> _favoriteWorkers;



  // List<WorkingTime> _workingTimes=[];
  // List<WorkingTime> get workingTimes  => _workingTimes;
  //
  // List<Service> _workerService=[];
  // List<Service> get services=> _workerService;
  //
  // bool _gettingTimeLoading=false;
  // bool get gettingTimeLoading=>_gettingTimeLoading;



  // Future getFavoriteWorkers(BuildContext context){
  //
  //   String? userId=Provider.of<AuthProvider>(context,listen: false).id;
  //
  //   return Dia.get(context, Api.GET_FAVOURITE_PROVIDERS(userId!),
  //
  //       onSuccess: (res)async{
  //
  //         var data=res.data;
  //
  //         _favoriteWorkers=[...Worker.toList(data)];
  //         notifyListeners();
  //
  //       },onError: (e){});
  // }




}