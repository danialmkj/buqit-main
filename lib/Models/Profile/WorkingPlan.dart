

import '../WorkingDay.dart';

class WorkingPlan{
  WorkingDay? monday;
  WorkingDay? tuesday;
  WorkingDay? wednesday;
  WorkingDay? thursday;
  WorkingDay? friday;
  WorkingDay? saturday;
  WorkingDay? sunday;

  WorkingPlan({
     this.monday,
     this.tuesday,
     this.wednesday,
     this.thursday,
     this.friday,
     this.saturday,
     this.sunday,
  });

  Map<String, dynamic> toMap() {
    return {
      'monday': this.monday,
      'tuesday': this.tuesday,
      'wednesday': this.wednesday,
      'thursday': this.thursday,
      'friday': this.friday,
      'saturday': this.saturday,
      'sunday': this.sunday,
    };
  }

  factory WorkingPlan.fromMap(Map<String, dynamic> map) {
    return WorkingPlan(
      monday:WorkingDay.fromMap( map['monday']),
      tuesday:WorkingDay.fromMap( map['tuesday']),
      wednesday:WorkingDay.fromMap( map['wednesday']),
      thursday:WorkingDay.fromMap( map['thursday']),
      friday:WorkingDay.fromMap( map['friday']),
      saturday:WorkingDay.fromMap( map['saturday']),
      sunday:WorkingDay.fromMap( map['sunday']),
    );
  }
}



class Break{
  String start;
  String end;

  Break({
    required this.start,
    required this.end,
  });

  static toList(data){
    return (data as List).map((map) => Break.fromMap(map)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'start': this.start,
      'end': this.end,
    };
  }

  factory Break.fromMap(Map<String, dynamic> map) {
    return Break(
      start: map['start'] as String,
      end: map['end'] as String,
    );
  }
}


