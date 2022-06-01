

import 'package:buqit/Models/Worker.dart';

import 'Photo.dart';

class Service {
  String id;
  String name;
  int duration;
  double price;
  String currency;
  List<Photo> photos;
  String categoryId;
  String providerId;
  Category category;
  Worker provider;

  Service({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.currency,
    required this.photos,
    required this.categoryId,
    required this.providerId,
    required this.category,
    required this.provider,
  });


  static List<Service> toList(map) {
    return (map as List).map((e) => Service.fromMap(e) ).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'duration': this.duration,
      'price': this.price,
      'currency': this.currency,
      'photos': this.photos,
      'categoryId': this.categoryId,
      'providerId': this.providerId,
      'category': this.category,
      'provider': this.provider,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as String,
      name: map['name'] as String,
      duration: map['duration'] as int,
      price: map['price'] as double,
      currency: map['currency'] as String,
      photos:Photo.toList(map['photos']),
      categoryId: map['categoryId'] as String,
      providerId: map['providerId'] as String,
      category:Category.fromMap(map['category']),
      provider:Worker.fromMap(map['provider']),
    );
  }
}

class Category{
  String id;
  String name;
  String? description;

  Category({
    required this.id,
    required this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description']
    );
  }
}


