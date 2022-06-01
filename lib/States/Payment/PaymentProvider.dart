



import 'package:buqit/Models/Payment/PaymentMethod.dart';
import 'package:buqit/Models/SearchHistory.dart';
import 'package:buqit/Models/Service.dart';
import 'package:buqit/Models/WorkPlace.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Models/Worker.dart';
import 'package:buqit/Models/WorkingDay.dart';
import 'package:buqit/Pages/SearchPage/SearchPage.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';


class PaymentProvider extends ChangeNotifier{




  PaymentMethod? _activePayment;
  PaymentMethod? get activePayment=>_activePayment;

  List<PaymentMethod> _paymentMethods=[];
  List<PaymentMethod> get  paymentMethods=>_paymentMethods;


   bool _loading = false;
   bool get loading => _loading;


  // List<WorkingTime> _workingTimes=[];
  // List<WorkingTime> get workingTimes  => _workingTimes;
  //
  // List<Service> _workerService=[];
  // List<Service> get services=> _workerService;
  //
  // bool _gettingTimeLoading=false;
  // bool get gettingTimeLoading=>_gettingTimeLoading;



  Future setActivePayment(BuildContext context,PaymentMethod payment,{Function? onSuccess}){
    return Dia.patch(context, Api.ACTIVE_PAYMENT(payment.id),
        hasLoading: true,
        onSuccess: (res)async{

          _activePayment=payment;
          notifyListeners();

      if(onSuccess!=null){
        onSuccess(res.data);
      }
      // print(res);

          // _activePayment=PaymentMethod.toList(res.data).firstWhere((element) => element.active);

          notifyListeners();

        },onError: (e){});
  }


  Future getPaymentMethods(BuildContext context, String workerId) async{


    _loading=true;
    notifyListeners();
    String? userId=Provider.of<AuthProvider>(context,listen: false).id;

    return Dia.get(context, Api.GET_PAYMENTS_METHOD(userId!),
        hasLoading: false,
        onSuccess: (res)async{




      _loading=false;
      _paymentMethods=[...PaymentMethod.toList(res.data)];
      _activePayment=PaymentMethod.toList(res.data).firstWhere((element) => element.active);

      notifyListeners();

    },onError: (e){});

  }

}