import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../blocs/model/brand_model.dart';

final brandModelProvider =
    StateNotifierProvider<DUMMYBRANDS, List<BrandModel>>((ref) {
  return DUMMYBRANDS();
});

class DUMMYBRANDS extends StateNotifier<List<BrandModel>> {
  DUMMYBRANDS() : super([]);
  final List<BrandModel> _items = const [
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
