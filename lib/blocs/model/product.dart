import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String imageUrl;
  late String title;
  late String price;
  late String quantity;
  late String description;
  late String category;
  late String brand;
  late String id;

  Product({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    required this.brand,
    required this.id,
  });

  Product.fromJson(DocumentSnapshot  json) {
    imageUrl = json["image"];
    title = json["title"];
    price = json["price"];
    quantity = json["quantity"];
    description = json["description"];
    category = json["category"];
    brand = json["brand"];
    id = json["id"];
  }

  @override
  String toString() {
    return 'Product(imageUrl: $imageUrl, title: $title, price: $price, quantity: $quantity, description: $description, category: $category, brand: $brand, id: $id)';
  }
}
