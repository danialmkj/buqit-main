import 'dart:convert';
import 'dart:io';

import 'package:buqit/Models/Profile/Profile.dart';
import 'package:buqit/Models/Profile/Setting.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/Profile/UpdateProfileFields.dart';
import 'package:buqit/States/Drawer/DrawerProvider.dart';
import 'package:buqit/Utils/Network/Api.dart';
import 'package:buqit/Utils/Network/NetworkManager.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  Profile? _profile;
  String? _id;

  // AuthStatus _authStatus=AuthStatus.None;

  bool get loggedIn => _isLoggedIn;

  Profile? get profile => _profile;

  String? get id => _id;

  // Future get token => _getToken();

  Future init(context, {onSuccess}) async {
    final storage =  const FlutterSecureStorage();
    String? token = await storage.read(key: "TOKEN");
    String? id = await storage.read(key: "ID");

    if (id != null) {
      return await Dia.get(context, Api.GET_PROFILE(id), hasLoading: false)
          .then((res) {
        Provider.of<DrawerProvider>(context, listen: false)
            .getDrawerItems(context, userId: id);

        _id = id;
        _isLoggedIn = true;
        _profile = Profile.fromMap(res.data);
        notifyListeners();
        // _authStatus=AuthStatus.Verified;
        return true;
      });
    } else {
      _isLoggedIn = false;
      notifyListeners();
      return false;
    }
  }

  updateImage(context, {required String imagePath, Function? onSuccess}) {
    // Dia.post(context, url)
  }

  login(context, {required String email, required String password}) async {
    final ipv4 = await Ipify.ipv4();
    Map<String, dynamic> meta = {};

    if (Platform.isAndroid) {
      // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // meta['deviceModel'] = androidInfo.manufacturer;
      // print(androidInfo.manufacturer);
    } else if (Platform.isIOS) {
      // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      //
      // print(iosInfo);
    }

    meta['platform'] = "IPHONE";
    meta['ipAddress'] = ipv4;
    meta['deviceModel'] = "model";

    print(email);
    print(password);

    var ara = await Dia.post(context, Api.SIGNIN,
        data: {"email": email, "password": password, "metadata": meta},
        onSuccess: (Response res) async {
      if (res.statusCode == 200) {
        _id = res.data['id'];
        _isLoggedIn = true;

        //
        FlutterSecureStorage storage = new FlutterSecureStorage();
        await storage.write(key: 'TOKEN', value: res.headers['token']![0]);
        await storage.write(key: 'ID', value: res.data['id']);
        //
        notifyListeners();
        Provider.of<DrawerProvider>(context, listen: false)
            .getDrawerItems(context, userId: id);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Pages.home, (route) => false);

        _profile = Profile.fromMap(res.data);
      } else {
        Fluttertoast.showToast(
            msg: "Server error has happened, please try again later.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      // print(res);
    }, onError: (e) {
      print(e);
    });

    print('ara ->${ara}');
  }

  // ignore: non_constant_identifier_names

  logOut(context) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'TOKEN');
    await storage.delete(key: 'ID');
    _isLoggedIn = false;
    _profile = null;

    Navigator.pushNamedAndRemoveUntil(context, Pages.splash, (route) => false);

    notifyListeners();
  }

  // ignore: non_constant_identifier_names

  verifyEmail(context,
      {required String code,
      required String email,
      required Function onSuccess}) async {
    return await Dia.post(context, Api.VERIFY_EMAIL(email, code)).then((res) {
      print(res.data);
      print(res);

      onSuccess(res);
    });
  }

  changePassword(context,
      {required String password,
      required String email,
      required String id,
      required Function onSuccess,
      required String code}) async {
    List pass = [];
    String temp = password;

    for (int i = 0; i < password.length; i++) {
      pass.add(temp[i]);
    }

    return await Dia.patch(context, Api.RESET_PASSWORD,
            data: {"userId": id, "verificationCode": code, "password": pass})
        .then((res) {
      onSuccess(res);

      Fluttertoast.showToast(
          msg: "Password changed successfully.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  verifyPasswordRecoveryCode(context,
      {required String code,
      required String email,
      required Function onSuccess}) async {
    return await Dia.post(
            context, Api.VERIFY_PASSWORD_RECOVERY_CODE(email, code))
        .then((res) {
      print(res.statusCode);

      if (res.statusCode == 200) {
        onSuccess(res);
      }
    });
  }

  resendPasswordRecoveryCode(context,
      {required Function onSuccess, required String email}) async {
    return await Dia.post(context, Api.RESEND_PASSWORD_RECOVERY_CODE(email))
        .then((res) {
      print(res.data);
      print(res);

      onSuccess(res);
    });
  }

  resendCode(context, {required Function onSuccess}) async {
    return await Dia.post(context, Api.RESEND_CODE(_profile?.id)).then((res) {
      print(res.data);
      print(res);

      onSuccess(res);
    });
  }

  setNotification(context,
      {required Function onSuccess,
      Function? onFail,
      required bool toggle}) async {
    return await Dia.patch(context, Api.SET_NOTIFICATION,
            data: {"userId": _profile?.id, "notificationsEnabled": toggle})
        .then((res) {
      _profile = _profile?.copyWith(
          settings: _profile?.settings.copyWith(notificationsEnabled: toggle));

      onSuccess(res);
    }).catchError((e) {
      onFail!(e);
    });
  }

  sendPasswordRecoveryCode(context,
      {required Function onSuccess,
      required Function onFail,
      required String email}) async {
    return await Dia.post(context, Api.RECOVER_PASSWORD(email)).then((res) {
      onSuccess(res);
    }).catchError((e) {
      onFail(e);
    });
  }

  register(context,
      {required String firstName,
      required String lastName,
      required String phone,
      required String password,
      required String email,
      required Function onSuccess,
      Function? onError}) async {
    List pass = [];
    String temp = password;

    for (int i = 0; i < password.length; i++) {
      pass.add(temp[i]);
    }

    print(pass);

    Dia.post(context, Api.SIGNUP, data: {
      'firstName': firstName,
      'email': email,
      'lastName': lastName,
      'phone': phone,
      'password': pass,
    }, onSuccess: (res) async {
      if (res.statusCode == 201) {
        FlutterSecureStorage storage = new FlutterSecureStorage();
        await storage.write(key: 'TOKEN', value: res.headers['token']![0]);
        await storage.write(key: 'ID', value: res.data['id']);

        _profile = Profile.fromMap(res.data);
        _isLoggedIn = true;
        _id = _profile?.id;

        notifyListeners();

        onSuccess.call(res);
      } else {
        Fluttertoast.showToast(
            msg: "Error happened, please try again.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }, onError: (res) {
      onError?.call(res);
    });
  }

  Future checkEmail(BuildContext context,
      {required Function(dynamic res) onSuccess, required String email}) async {
    return await Dia.get(context, Api.CHECK_EMAIL(email)).then((res) {
      if (res.data == "AVAILABLE") {
        Navigator.of(context).pushNamed(Pages.register, arguments: email);
        // onSuccess(res);

      } else if (res.data == "REGISTERED_TO_CUSTOMER") {
        Navigator.of(context).pushNamed(Pages.password, arguments: email);
      } else {
        Fluttertoast.showToast(
            msg: "Email has already been registered.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  Future registerCheckEmail(BuildContext context,
      {required Function(dynamic res) onSuccess, required String email}) async {
    return await Dia.get(context, Api.CHECK_EMAIL(email)).then((res) {
      if (res.data == "AVAILABLE") {
        Navigator.of(context).pushNamed(Pages.register, arguments: email);
        // onSuccess(res);

      } else if (res.data == "REGISTERED_TO_CUSTOMER") {
        Fluttertoast.showToast(
            msg: "Email has already been registered.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Email has already been registered.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void updateField(BuildContext context,
      {required FieldType type,
      required Function onSuccess,
      required Map<String, dynamic> data}) {
    print(data);
    Dia.patch(context, Api.UPDATE_PROFILE, data: data).then((res) {
      onSuccess(res);
    }).catchError((e) {});
  }
}
