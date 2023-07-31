import 'dart:convert';

class CarModel {
  int? id;
  String? name;
  String? brand;
  String? model;
  String? photo;
  double? price;

  CarModel({
    this.id,
     this.name,
     this.brand,
     this.model,
     this.photo,
     this.price,
  });

  get getId => id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'photo': photo,
      'price': price,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] as int,
      name: map['name'] as String,
      brand: map['brand'] as String,
      model: map['model'] as String,
      photo: map['photo'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) =>
      CarModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
