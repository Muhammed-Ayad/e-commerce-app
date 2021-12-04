import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../blocs/model/category_model.dart';


final categoryModellProvider =
    StateNotifierProvider<DUMMYCATEGORIES, List<CategoryModel>>((ref) {
  return DUMMYCATEGORIES();
});

class DUMMYCATEGORIES extends StateNotifier<List<CategoryModel>> {
  DUMMYCATEGORIES() : super([]);

  final List<CategoryModel> _items = const [
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
