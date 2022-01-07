import 'package:flutter/material.dart';

import './categories_screen.dart';

class CategoriesScrollHorizontal extends StatelessWidget {
     static const id = 'CategoriesScrollHorizontal';

  const CategoriesScrollHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CategoriesScreen(
      crossAxisCount: 1,
      scrollDirection: Axis.horizontal,
      height: 110,
    );
  }
}
