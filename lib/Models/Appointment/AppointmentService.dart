

class AppointmentService{

  String name;
  int duration;
  double amount;
  double servicePrice;
  String currency;
  List<dynamic> photos;

  AppointmentService({
    required this.name,
    required this.duration,
    required this.amount,
    required this.servicePrice,
    required this.currency,
    required this.photos,
  });


  static toList(data){
    return (data as List).map((map) => AppointmentService.fromMap(map)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'duration': this.duration,
      'amount': this.amount,
      'servicePrice': this.servicePrice,
      'currency': this.currency,
      'photos': this.photos,
    };
  }

  factory AppointmentService.fromMap(Map<String, dynamic> map) {
    return AppointmentService(
      name: map['name'] as String,
      duration: map['duration'] as int,
      amount: map['amount'] as double,
      servicePrice: map['servicePrice'] as double,
      currency: map['currency'] as String,
      photos: map['photos'] ,
    );
  }
}