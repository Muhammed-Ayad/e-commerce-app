import 'package:flutter/material.dart';

import './brands_screen.dart';

class BrandsScrollHorizontal extends StatelessWidget {
   static const id = 'BrandsScrollHorizontal';
  const BrandsScrollHorizontal({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const BrandsScreen(
        crossAxisCount: 1,
        scrollDirection: Axis.horizontal,
        height: 150,
      );
  }
}