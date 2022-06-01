

class Workplace{
  String id;
  String name;
  String address;
  double latitude;
  double longitude;

  Workplace({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'address': this.address,
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }


  static toList(data){
    return (data as List).map((map) => Workplace.fromMap(map)).toList();
  }

  factory Workplace.fromMap(Map<String, dynamic> map) {
    return Workplace(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}