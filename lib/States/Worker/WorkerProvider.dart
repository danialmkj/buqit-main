

import 'package:buqit/Models/SearchHistory.dart';
import 'package:buqit/Models/Service.dart';
import 'package:buqit/Models/WorkPlace.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Models/WorkingDay.dart';
import 'package:buqit/Pages/SearchPage/SearchPage.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Utils/DateUtility.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';


class WorkerProvider extends ChangeNotifier{




  List<Worker> _nearbyProviders=[];
  List<Worker> get nearbyProviders  => _nearbyProviders;

  List<WorkingTime> _workingTimes=[];
  List<WorkingTime> get workingTimes  => _workingTimes;

  List<Service> _workerService=[];
  List<Service> get services=> _workerService;

  List<Worker> _favoriteWorkers=[];
  List<Worker> get favoriteWorkers=> _favoriteWorkers;

  bool _gettingTimeLoading=false;
  bool get gettingTimeLoading=>_gettingTimeLoading;




  Future getAvailableTimes(context,{required String workerId,required List<Service?> selectedServices,required DateTime? date,required Function onSuccess,required Function onError}) {

    // _gettingTimeLoading=true;
    // notifyListeners();

    print(DateFormat('yyyy-mm-dd').format(date!));

    return Dia.post(context, Api.GET_AVAILABLE_TIMES(workerId),
        // hasLoading: false,
        data: {
      "serviceIds":[...selectedServices.map((e) => e?.id)],
          "date":DateFormat('yyyy-MM-dd').format(date)
        },
        onSuccess: (res)async{
          // _gettingTimeLoading=false;
      _workingTimes=[...WorkingTime.toList(res.data)];
      onSuccess(WorkingTime.toList(res.data));
      notifyListeners();


    },onError: (e){
          // _gettingTimeLoading=false;
          onError(e);

        });

  }


  Future chekWorkerFavourite(context,String workerId)async{

    String? userId=Provider.of<AuthProvider>(context,listen: false).id;


    return Dia.get(context,Api.CHECK_PROVIDER_FAVOURITE(workerId,userId!),
        hasLoading: false,
        onSuccess: (res)async{

    },onError: (e){});
  }

  Future likeOrDislikeWorker(context,String workerId, {required Function onSuccess,required Function onError})async{

    String? userId=Provider.of<AuthProvider>(context,listen: false).id;



    return Dia.post(context,Api.LIKE_PROVIDER(workerId,userId!),
        hasLoading: false,
        onSuccess: (res)async{

         
          onSuccess(res);
        },onError: (e){

      onError(e);
        });
  }

  Future getFavoriteWorkers(BuildContext context){

    String? userId=Provider.of<AuthProvider>(context,listen: false).id;

    return Dia.get(context, Api.GET_FAVOURITE_PROVIDERS(userId!),

        onSuccess: (res)async{

          var data=res.data;

          _favoriteWorkers=[...Worker.toList(data)];
          notifyListeners();

        },onError: (e){});
  }

   getGroupedServices(context){


    Map<String,List<Service>> map={};
    _workerService.forEach((service) {
      String category=service.category.name;
      if(map.containsKey(service.category.name)){
        map[category]?.add(service);
      }else{
        map[category]=[];
      }
    });

    return map;
  }

  Future requestService(context,
      {required DateTime start,
      required DateTime end,
      required List<String> serviceIds,
      required String workerId,
      required Function onSuccess
      }){

    String? userId=Provider.of<AuthProvider>(context,listen: false).id;


    print(DateUtility(dateTime: start).renderToJsonDate());

    return Dia.post(context,Api.REQUEST_SERVICE,
        data: {
          "start":DateUtility(dateTime: start).renderToJsonDate(),
          "end":DateUtility(dateTime: end).renderToJsonDate(),
          "serviceIds":serviceIds,
          "providerId":workerId,
          "customerId":userId
        },
        hasLoading: true,
        onSuccess: (res)async{

          if(onSuccess!=null){
            return onSuccess(res.data);
          }
        },onError: (e){});
  }


  Future getWorkerService(BuildContext context, String workerId) {


    return Dia.get(context, Api.GET_PROVIDERS_SERVICE(workerId),onSuccess: (res)async{
          _workerService=Service.toList(res.data);
    },onError: (e){});

  }

  Future getNearbyWorkers(BuildContext context, {required LatLng latLng,required Function onSuccess,required onError}) {


    return Dia.post(context, Api.GET_NEARBY_PROVIDERS,
        data: {"latitude":latLng.latitude,"longitude":latLng.longitude},
        onSuccess: (res)async{

          // print(res.data);
          print(latLng);

      List<Worker> workers=Worker.toList(res.data);

      print(workers);
      _nearbyProviders=workers;
      onSuccess(workers);
      notifyListeners();

    },onError: (e){onError(e);},hasLoading: false);
  }

}