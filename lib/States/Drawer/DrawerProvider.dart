





import 'package:buqit/Models/Drawer/DrawerItemModel.dart';
import 'package:buqit/Models/Payment/PaymentMethod.dart';
import 'package:buqit/Models/SearchHistory.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';


class DrawerProvider extends ChangeNotifier{



  Map<String,dynamic> _icons={
    "MENU_ITEM_APPOINTMENTS":CupertinoIcons.calendar_badge_plus,
    "MENU_ITEM_FAVORITES":CupertinoIcons.heart,
    "MENU_ITEM_PAYMENT":CupertinoIcons.creditcard,
    "MENU_ITEM_DISCOUNTS":CupertinoIcons.tag,
    "MENU_ITEM_SUPPORT":CupertinoIcons.chat_bubble,
    "MENU_ITEM_ABOUT":CupertinoIcons.info,
    "MENU_ITEM_SETTINGS":CupertinoIcons.slider_horizontal_3,
  };

  Map<String,dynamic> get  icons=>_icons;


  List<DrawerItemModel> _items=[];
  List<DrawerItemModel> get  items=>_items;



  bool _loading=false;
  bool get loading=>_loading;


  // List<WorkingTime> _workingTimes=[];
  // List<WorkingTime> get workingTimes  => _workingTimes;
  //
  // List<Service> _workerService=[];
  // List<Service> get services=> _workerService;
  //
  // bool _gettingTimeLoading=false;
  // bool get gettingTimeLoading=>_gettingTimeLoading;



  Future getDrawerItems(BuildContext context, {String? userId}){


    _loading=true;
    notifyListeners();

    String? id=userId;
    if(userId==null){
      id=Provider.of<AuthProvider>(context,listen: false).id;
    }

    // String? userId=Provider.of<AuthProvider>(context,listen: false).id;


    return Dia.get(context, Api.GET_DRAWER_CONTENT(id!),
        hasLoading: false,
        onSuccess: (res)async{



          _loading=false;
          _items=[...DrawerItemModel.toList(res.data)];
          notifyListeners();

        },onError: (e){
          _loading=false;
          notifyListeners();

        });
  }



}