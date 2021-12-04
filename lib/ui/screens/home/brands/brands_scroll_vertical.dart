import 'package:flutter/material.dart';

import './brands_screen.dart';

class BrandsScrollVertical extends StatelessWidget {
   static const id = 'BrandsScrollVertical';
  const BrandsScrollVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Brands'),
        centerTitle: true,
      ),
      body: const BrandsScreen(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        height: double.infinity,
      ),
    );
  }
}
