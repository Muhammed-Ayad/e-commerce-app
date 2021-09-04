import 'package:flutter/foundation.dart';

class BrandModel {
  final String title;
  final String image;
 const BrandModel({
    required this.title,
    required this.image,
  });
}

class DUMMYBRANDS with ChangeNotifier {
  List<BrandModel> _items =const [
 
     BrandModel(
      title: 'Apple',
      image: 'assets/images/brand/apple.png',
    ),
    
     BrandModel(
      title: 'Dell',
      image: 'assets/images/brand/dell.png',
    ),
      BrandModel(
      title: 'Hp',
      image: 'assets/images/brand/hp.png',
    ),
      BrandModel(
      title: 'Huawel',
      image: 'assets/images/brand/huawel.png',
    ),
     
      BrandModel(
      title: 'Oppo',
      image: 'assets/images/brand/oppo.png',
    ),
       BrandModel(
      title: 'Realme',
      image: 'assets/images/brand/realme.png',
    ),
       BrandModel(
      title: 'Samsung',
      image: 'assets/images/brand/samsung.png',
    ),
     BrandModel(
      title: 'Sony',
      image: 'assets/images/brand/sony.png',
    ),
  ];
  List<BrandModel> get items {
    return [..._items];
  }
}

