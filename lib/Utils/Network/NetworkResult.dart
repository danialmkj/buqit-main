

class ResultData {
  var data;
  bool result;
  int code;
  var headers;
  String? msg;
  dynamic error;

  ResultData(this.data, this.result, this.code, {this.headers, this.msg,this.error});
}

enum MessageType{
  errorToast,
  successDialog,
  warningDialog,
  errorDialog,
  successToast,
  warningToast,
}

class NetworkResult {
  bool error;
  String message;
  MessageType messageType;
  bool close;
  bool logOut;
  bool? openLogin;
  bool? openPayment;
  bool continuation;
  Map<String,dynamic>? data;


  NetworkResult({required this.continuation, this.data,required this.message, this.openLogin, this.openPayment, required this.messageType,required this.error,required this.close,required  this.logOut, });

  static NetworkResult fromJson(Map<String, dynamic> json){
    return NetworkResult(

      message: json['message'] as String,
      messageType: MessageType.values.where((value)=>value.toString().split('.').last==json['messageType']).first,
      error: json['error'] as bool,
      continuation: json['continuation'] as bool,
      close: json['close'] as bool,
      logOut: json['logOut'] as bool,
      openLogin: json['openLogin'] as bool,
      openPayment: json['openPayment'] as bool,
      data:json['data']!=null ? json['data'] as Map<String,dynamic> : null,
    );
  }
}