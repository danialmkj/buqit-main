

class Customer {

  String id;
  String? firstname;
  String? lastname;
  String? phone;
  String? photoUrl;
  double rating;

  Customer({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.phone,
    required this.photoUrl,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'firstname': this.firstname,
      'lastname': this.lastname,
      'phone': this.phone,
      'photoUrl': this.photoUrl,
      'rating': this.rating,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as String,
      firstname: map['firstname'] as String?,
      lastname: map['lastname'] as String?,
      phone: map['phone'] as String?,
      photoUrl: map['photoUrl'] as String?,
      rating: map['rating'] as double,
    );
  }
}