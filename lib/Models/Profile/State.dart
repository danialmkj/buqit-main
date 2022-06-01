

class State{
  double ratingScore;
  int ratingCount;
  int completedAppointmentsCount;
  int durationInDays;
  int durationInMonths;
  int durationInYears;

  State({
    required this.ratingScore,
    required this.ratingCount,
    required this.completedAppointmentsCount,
    required this.durationInDays,
    required this.durationInMonths,
    required this.durationInYears,
  });

  Map<String, dynamic> toMap() {
    return {
      'ratingScore': this.ratingScore,
      'ratingCount': this.ratingCount,
      'completedAppointmentsCount': this.completedAppointmentsCount,
      'durationInDays': this.durationInDays,
      'durationInMonths': this.durationInMonths,
      'durationInYears': this.durationInYears,
    };
  }

  factory State.fromMap(Map<String, dynamic> map) {
    return State(
      ratingScore: map['ratingScore'] as double,
      ratingCount: map['ratingCount'] as int,
      completedAppointmentsCount: map['completedAppointmentsCount'] as int,
      durationInDays: map['durationInDays'] as int,
      durationInMonths: map['durationInMonths'] as int,
      durationInYears: map['durationInYears'] as int,
    );
  }
}