import 'package:flutter/material.dart';

import './categories_screen.dart';

class CategoriesScrollVertical extends StatelessWidget {
       static const id = 'CategoriesScrollVertical';

  const CategoriesScrollVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: const CategoriesScreen(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        height: double.infinity,
      ),
    );
  }
}
