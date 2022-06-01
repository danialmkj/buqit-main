import 'package:buqit/Models/Profile/WorkingPlan.dart';
import 'package:buqit/Models/WorkPlace.dart';

class Worker{
  String id;
  String firstName;
  String lastName;
  String phone;
  String photoUrl;
  double rating;
  Workplace workplace;
  WorkingPlan? workingPlan;

  Worker({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.photoUrl,
    required this.rating,
    required this.workplace,
    required this.workingPlan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'phone': this.phone,
      'photoUrl': this.photoUrl,
      'rating': this.rating,
      'workplace': this.workplace,
      'workingPlan': this.workingPlan,
    };
  }


  static toList(data){
    return (data as List).map((map) => Worker.fromMap(map)).toList();
  }

  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      photoUrl: map['photoUrl'] as String,
      rating: map['rating'] as double,
      workplace: Workplace.fromMap(map['workplace']),
      workingPlan:map['workingPlan'] !=null ?  WorkingPlan.fromMap(map['workingPlan']) : null,
    );
  }
}