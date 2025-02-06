import 'dart:ffi';

class FoodItem {
  int id;
  String name;
  double price;
  String type;
  String category;
  String imgUrl;

  // Constructor
  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
    required this.category,
    required this.imgUrl,
  });

  // fromJson method
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      type: json['type'],
      category: json['category'],
      imgUrl: json['imgUrl'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'type': type,
      'category': category,
      'imgUrl': imgUrl,
    };
  }

  @override
  String toString() {
    return 'FoodItem{id: $id, name: $name, price: $price, type: $type, category: $category, imgUrl: $imgUrl}';
  }
}
