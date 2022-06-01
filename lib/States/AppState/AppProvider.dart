

import 'dart:convert';
import 'dart:io';

import 'package:buqit/Models/Profile/Profile.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';


class AppProvider extends ChangeNotifier{




  bool _dark= false;
  bool get dark  => _dark;



  switchDark(){
    _dark=!_dark;
    notifyListeners();
  }




}