import 'dart:developer';


 import 'package:e_commerce_app/blocs/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './categories.dart';
import '../../../../services/riverpod/state_provider.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryItem({Key? key, required this.categoryModel}) : super(key: key);
  

  
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => InkWell(
        onTap: () {
          log(categoryModel.title);
          ref.read(categoryProvider.state).state = categoryModel.title;
           Navigator.pushNamed(
                                  context, Categories.id);
      
        },
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: SizedBox(
                height: 150,
                child: Image.asset(
                  categoryModel.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Text(
                categoryModel.title,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
