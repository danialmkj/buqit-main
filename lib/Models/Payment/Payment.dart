

class Payment{
  double refundAmount;
  double amount;
  String last4Digits;
  String brand;

  Payment({
    required this.refundAmount,
    required this.amount,
    required this.last4Digits,
    required this.brand,
  });

  Map<String, dynamic> toMap() {
    return {
      'refundAmount': this.refundAmount,
      'amount': this.amount,
      'last4Digits': this.last4Digits,
      'brand': this.brand,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      refundAmount: map['refundAmount'] as double,
      amount: map['amount'] as double,
      last4Digits: map['last4Digits'] as String,
      brand: map['brand'] as String,
    );
  }
}