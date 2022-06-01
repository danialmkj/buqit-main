

class PaymentMethod{
  String id;
  String? last4Digits;
  String? brand;
  bool validated;
  bool expired;
  bool active;

  PaymentMethod({
    required this.id,
    this.last4Digits,
    this.brand,
    required this.validated,
    required this.expired,
    required this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'last4Digits': this.last4Digits,
      'brand': this.brand,
      'validated': this.validated,
      'expired': this.expired,
      'active': this.active,
    };
  }

  static List<PaymentMethod> toList(map) {
    return (map as List).map((e) => PaymentMethod.fromMap(e) ).toList();
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as String,
      last4Digits: map['last4Digits'] as String?,
      brand: map['brand'] as String?,
      validated: map['validated'] as bool,
      expired: map['expired'] as bool,
      active: map['active'] as bool,
    );
  }
}