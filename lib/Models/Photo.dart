

class Photo{
  String id;
  String url;
  bool linked;
  String serviceId;

  Photo({
    required this.id,
    required this.url,
    required this.linked,
    required this.serviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'url': this.url,
      'linked': this.linked,
      'serviceId': this.serviceId,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'] as String,
      url: map['url'] as String,
      linked: map['linked'] as bool,
      serviceId: map['serviceId'] as String,
    );
  }

  static List<Photo> toList(res) {
    return (res as  List).map((e) => Photo.fromMap(e) ).toList();
  }
}