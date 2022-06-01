
import 'package:buqit/Models/Payment/PaymentMethod.dart';
import 'package:buqit/Models/Profile/Setting.dart';
import 'package:buqit/Models/Profile/State.dart';

class Profile{

  String id ;
  String firstName ;
  String lastName ;
  String email ;
  String phone ;
  String? photoUrl ;
  int statusCode ;
  String role ;
  Setting settings;
  List<PaymentMethod> paymentMethods;
  State stats;
  Update updates;
  Verification verification;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.statusCode,
    required this.role,
    required this.settings,
    required this.stats,
    this.paymentMethods=const [],
    required this.updates,
    required this.verification
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'phone': this.phone,
      'photoUrl': this.photoUrl,
      'statusCode': this.statusCode,
      'role': this.role,
      'settings': this.settings,
      'paymentMethods': this.paymentMethods,
      'stats': this.stats,
      'updates': this.updates,
      'verification': this.verification,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      photoUrl: map['photoUrl'] as String?,
      statusCode: map['statusCode'] as int,
      role: map['role'] as String,
      settings: Setting.fromMap(map['settings']),
      paymentMethods:PaymentMethod.toList(map['paymentMethods']),
      stats: State.fromMap(map['stats']),
      updates: Update.fromMap(map['updates']),
      verification:Verification.fromMap(map['verification']),
    );
  }

  Profile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? photoUrl,
    int? statusCode,
    String? role,
    Setting? settings,
    List<PaymentMethod>? paymentMethods,
    State? stats,
    Update? updates,
    Verification? verification,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      statusCode: statusCode ?? this.statusCode,
      role: role ?? this.role,
      settings: settings ?? this.settings,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      stats: stats ?? this.stats,
      updates: updates ?? this.updates,
      verification: verification ?? this.verification,
    );
  }
}

class Update{
  DateTime? lastEmailUpdate;
  DateTime? lastPasswordUpdate;

  Update({
    required this.lastEmailUpdate,
    required this.lastPasswordUpdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'lastEmailUpdate': this.lastEmailUpdate,
      'lastPasswordUpdate': this.lastPasswordUpdate,
    };
  }

  factory Update.fromMap(Map<String, dynamic> map) {
    return Update(
      lastEmailUpdate: map['lastEmailUpdate']  !=null ? DateTime.parse(map['lastEmailUpdate'] ) : null ,
      lastPasswordUpdate:  map['lastPasswordUpdate']  !=null ? DateTime.parse(map['lastPasswordUpdate'] ) : null ,
    );
  }
}


class Verification{
  bool verified;

  Verification({
    required this.verified,
  });

  Map<String, dynamic> toMap() {
    return {
      'verified': this.verified,
    };
  }

  factory Verification.fromMap(Map<String, dynamic> map) {
    return Verification(
      verified: map['verified'] as bool,
    );
  }
}


