import 'Profile/WorkingPlan.dart';

class WorkingDay{
  bool? open;
  String start;
  String end;
  List<Break>? breaks;

  WorkingDay({
    this.open,
    required this.start,
    required this.end,
    this.breaks,
  });

  Map<String, dynamic> toMap() {
    return {
      'open': this.open,
      'start': this.start,
      'end': this.end,
      'breaks': this.breaks,
    };
  }

  factory WorkingDay.fromMap(Map<String, dynamic> map) {
    return WorkingDay(
      open: map['open'] as bool?,
      start: map['start'] as String,
      end: map['end'] as String,
      breaks:map['breaks']!=null ? Break.toList((map['breaks'])) : null,
    );
  }

  static toList(data) {
    return (data as List).map((e) => WorkingDay.fromMap);
  }
}


class WorkingTime{
  DateTime start;
  DateTime end;

  WorkingTime({
    required this.start,
    required this.end,
  });


  static  toList(data) {
    return (data as List).map((e) => WorkingTime.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'start': this.start,
      'end': this.end,
    };
  }

  factory WorkingTime.fromMap(Map<String, dynamic> map) {
    return WorkingTime(
      start:DateTime.parse(map['start']),
      end: DateTime.parse(map['end']),
    );
  }
}