import 'package:flutter/foundation.dart';

class CategoryModel {
  final String title;
  final String image;

  const CategoryModel({
    required this.title,
    required this.image,
  });
}

class DUMMYCATEGORIES with ChangeNotifier {
  List<CategoryModel> _items = const [
   
    CategoryModel(
      title: 'Camera',
      image: 'assets/images/category/camera.png',
    ),
    CategoryModel(
      title: 'HeadPhone',
      image: 'assets/images/category/headphones.png',
    ),
    CategoryModel(
      title: 'Laptop',
      image: 'assets/images/category/laptop.png',
    ),
    CategoryModel(
      title: 'Phone',
      image: 'assets/images/category/phone.png',
    ),
    CategoryModel(
      title: 'Watches',
      image: 'assets/images/category/watches.png',
    ),
    CategoryModel(
      title: 'Tablet',
      image: 'assets/images/category/tablet.png',
    ),
  
  ];

  List<CategoryModel> get items {
    return [..._items];
  }
}
