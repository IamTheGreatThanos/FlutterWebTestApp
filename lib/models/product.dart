import 'owner.dart';

class Product {
  late int id;
  late String name;
  late String description;
  late int price;
  late String image;
  late Owner owner;
  late String code;
  late bool in_stock;
  late double rating;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image,
      required this.owner,
      required this.code,
      required this.in_stock,
      required this.rating});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    owner = (json['owner'] != null ? new Owner.fromJson(json['owner']) : null)!;
    code = json['code'];
    in_stock = json['in_stock'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['image'] = this.image;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['code'] = this.code;
    data['in_stock'] = this.in_stock;
    data['rating'] = this.rating;
    return data;
  }
}
