import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

import 'Api.dart';
import 'NetworkResult.dart';

// import 'package:school_happy/Components/Snack/Snack.dart';



class DebugUtil {
  static final bool isDebugMode = true;

  static debug(msg) {
    if (isDebugMode) {
      // print(msg);
    }
  }
}



class DiaManager {
  Dio _dio = new Dio();






  String _baseUrl = Api.BASE_URL;

  DiaManager() {
    // _dio.interceptors.add(new ErrorInterceptors(_dio));
  }

  // _setCert(){
  //   (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
  //     DebugUtil.debug("[dio] onHttpClientCreate");
  //     client.badCertificateCallback = (X509Certificate cert, String host, int port) {
  //       DebugUtil.debug("[dio] badCertificateCallback " + host);
  //       return true;
  //     };
  //   };
  // }

  Options _getOption() {
    return Options(
      sendTimeout: 15000,
      receiveTimeout: 15000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
  }



  Future get(context,url, {params,CancelToken? cancelToken, Map<String, dynamic>? header, onSuccess, onError, baseUrl,hasLoading}) async {


    Options baseOptions = _getOption();

    baseOptions.method = "GET";
    return await request(context,(baseUrl ?? _baseUrl) + url, params, onSuccess,
        onError, header, baseOptions,
        cancelToken: cancelToken,hasLoading: hasLoading!=null ? hasLoading : true);
  }

  Future delete(context,url, {params,CancelToken? cancelToken, Map<String, dynamic>? header, onSuccess, onError, data, baseUrl,hasLoading}) async {

    Options baseOptions = _getOption();

    baseOptions.method = "DELETE";
    return await request(context,(baseUrl ?? _baseUrl) + url, params, onSuccess,
        onError, header!, baseOptions,
        cancelToken: cancelToken!,data:data,hasLoading: hasLoading!=null ? hasLoading : true);
  }

  Future post(context,url, {params=const {},CancelToken? cancelToken, Map<String, dynamic>? header, onSuccess, onError, baseUrl, data,hasLoading}) async {






    // await readFromSecureStorage(key:'USER_TOKEN',onSuccess:(token){
    //   fd.fields.add(MapEntry('userToken', token));
    // });
    //
    // await readFromSecureStorage(key:'USER_TEMP_TOKEN',onSuccess:(token){
    //   fd.fields.add(MapEntry('userTempToken', token));
    // });



    // print(data);
    Options baseOptions = _getOption();

    baseOptions.method = "POST";
    return await request(
        context,(baseUrl ?? _baseUrl) + url, params, onSuccess,
        onError, header, baseOptions,
        cancelToken: cancelToken,data:data,hasLoading: hasLoading!=null ? hasLoading : true
    );
  }


  Future put(context,url, {params,CancelToken? cancelToken, Map<String, dynamic>? header, onSuccess, onError, baseUrl, data,hasLoading}) async {

    Options baseOptions = _getOption();
    baseOptions.method = "PUT";
    return await request(context,(baseUrl ?? _baseUrl) + url, params, onSuccess,
        onError, header, baseOptions,
        cancelToken: cancelToken!,data:data,hasLoading: hasLoading!=null ? hasLoading : true);
  }

  Future patch(context,url, {params, Map<String, dynamic>? header, onSuccess, onError, baseUrl, data,hasLoading}) async {

    Options baseOptions = _getOption();
    baseOptions.method = "PATCH";
    return await request(context,(baseUrl ?? _baseUrl) + url, params, onSuccess,
        onError, header, baseOptions,data:data,hasLoading: hasLoading!=null ? hasLoading : true);
  }



  download(context,url, String destination ,{CancelToken? cancelToken, Map<String, dynamic>? header, onSuccess, onError, baseUrl, data,downloadProgress}) async {

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio.download(url,destination,onReceiveProgress:downloadProgress,).then((value){

      onSuccess(value);
    }).catchError((e){


      // toast(context,text: 'خطایی در دانلود فایل های نشانه پیش آمده.',type: ToastType.Error);
    });
  }

  // _resultError(dynamic e) {
  //
  //   Response errorResponse;
  //
  //   if(e.runtimeType!= DioError){
  //
  //     return ResultData(e, false, 600, msg:e.toString());
  //   }
  //
  //
  //   if (e.response != null) {
  //     errorResponse = e.response;
  //   } else {
  //     errorResponse = new Response(statusCode: StatusCode.INTERNAL_ERROR,requestOptions: RequestOptions(path: ''));
  //   }
  //
  //
  //   if (e.type == DioErrorType.connectTimeout ||
  //       e.type == DioErrorType.receiveTimeout) {
  //     errorResponse.statusCode = StatusCode.NETWORK_TIME_OUT;
  //   }
  //
  //
  //   print('elegant -> ${e.response}');
  //
  //   return new ResultData(
  //       StatusCode.errorHandleFunction(
  //           errorResponse.statusCode, e.message,false),
  //       false,
  //       errorResponse.statusCode!,
  //       msg: e?.response?.data['message'] ?? 'error');
  // }

  Future request(context,url, params, Function? onSuccess, Function? onError, Map<String, dynamic>? header, Options option, {CancelToken? cancelToken, data,hasLoading=true}) async {

    if(hasLoading){
      showLoadingDialog(tapDismiss: false);
      // Provider.of<LoadingProvider>(context,listen: false).setLoading(true);
    }
    print(url);

    Map<String, dynamic> headers = new HashMap();


    headers['Connection'] = 'keep-alive';
    // headers['Accept'] = 'application/json';
    await FlutterSecureStorage().read(key: 'TOKEN').then((token){
      if(token!=null){
        headers['Authorization']='Bearer $token';
      }

    }).catchError((e){

    });








    if (header != null) {
      headers.addAll(header);
    }
    if (option != null) {
      option.headers = headers;

    } else {

      option = new Options(method: "GET");
      option.headers = headers;

    }



    // var fixedParams={'phoneUniqueCode':phoneUniqueCode,'deviceType':'android','appVersion':appVersion};


    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };


    return await _dio.request(url, data: data, queryParameters: params!=null ? {...params } : {}, options: option, cancelToken: cancelToken,).then((res) {




      hideLoadingDialog();


      if(onSuccess!=null){
        onSuccess(res);
      }


      return res;


      // var decodedResponse=json.decode(res.data.toString());
      //
      // print(decodedResponse);
      // //
      //
      //
      //
      // NetworkResult result=NetworkResult.fromJson(decodedResponse);

    }).catchError((e) {

      print(e.message);
      print(e.response);
      if(onError!=null){
        onError(e);
      }


      Fluttertoast.showToast(
          msg: "Server error has happened, please try again later.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );



      hideLoadingDialog();
      // onError(e);

      if(e is DioError){






      }
      throw(e);

      //   if(onError!=null){
      //     onError(e);
      //   }
      //
      // return _resultError(e);

    });

  }
}

final DiaManager Dia = new DiaManager();

