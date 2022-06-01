

import 'package:buqit/Models/Profile/WorkingPlan.dart';

class Setting{

  String userId;
  bool notificationsEnabled;
  WorkingPlan? workingPlan;
  String paymentMethodId;

  Setting({
    required this.userId,
    required this.notificationsEnabled,
    required this.workingPlan,
    required this.paymentMethodId,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'notificationsEnabled': this.notificationsEnabled,
      'workingPlan': this.workingPlan,
      'paymentMethodId': this.paymentMethodId,
    };
  }

  factory Setting.fromMap(Map<String, dynamic> map) {
    return Setting(
      userId: map['userId'] as String,
      notificationsEnabled: map['notificationsEnabled'] as bool,
      workingPlan: map['workingPlan']!=null ? WorkingPlan.fromMap(map['workingPlan'],) : null ,
      paymentMethodId: map['paymentMethodId'] as String,
    );
  }

  Setting copyWith({
    String? userId,
    bool? notificationsEnabled,
    WorkingPlan? workingPlan,
    String? paymentMethodId,
  }) {
    return Setting(
      userId: userId ?? this.userId,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      workingPlan: workingPlan ?? this.workingPlan,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
    );
  }
}

