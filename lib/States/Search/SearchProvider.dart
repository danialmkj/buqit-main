

import 'package:buqit/Models/SearchHistory.dart';
import 'package:buqit/Models/WorkPlace.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Pages/SearchPage/SearchPage.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class SearchProvider extends ChangeNotifier{


  List<SearchHistory> _searchHistory=[];
  List<SearchHistory> get searchHistory  => _searchHistory;



  List<String> _services=[];
  List<String> get services  => _services;


  getNearbyWorkplaces(){

    notifyListeners();
  }

  getSearchHistory(context)async {
    var id=Provider.of<AuthProvider>(context,listen: false).id;



    await Dia.get(context, Api.SEARCH_HISTORY(id),onSuccess: (Response res){

      _searchHistory=[...SearchHistory.toList(res.data)];
      notifyListeners();
    },onError: (DioError e){
      // print(e.message);
    });
  }

  // Future getServices(context,text)async{
  //
  //   return Dia.get(context, Api.GET_SERVICES(text),onSuccess: (v){},onError: (e){});
  //
  // }
  //
  // Future getWorkPlaces(context,text)async{
  //   return Dia.get(context, Api.GET_WORKPLACES(text),onSuccess: (v){},onError: (e){});
  // }
  //
  // void search(context,{required SearchType type, text})async {
  //
  //   if(text!=""){
  //     switch(type){
  //       case SearchType.workPlace:
  //
  //         var res=await getWorkPlaces(context,text);
  //         _workPlaces=[...Workplace.toList(res.data)];
  //
  //
  //         notifyListeners();
  //         return ;
  //
  //       case SearchType.service:
  //
  //         var res=await getServices(context,text);
  //         _services=[...res.data];
  //         notifyListeners();
  //
  //         return;
  //     }
  //   }
  //
  //
  //
  //   notifyListeners();
  // }
  //
  // Future getProviders(context,String workplaceId) {
  //   return Dia.get(context, Api.GET_PROVIDERS(workplaceId),onSuccess: (res)async{
  //
  //
  //     _workers=[...Worker.toList(res.data)];
  //     notifyListeners();
  //
  //
  //   },onError: (e){});
  // }
  //


}