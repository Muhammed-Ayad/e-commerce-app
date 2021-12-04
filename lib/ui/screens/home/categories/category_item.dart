import 'dart:developer';


 import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './categories.dart';
import '../../../../services/riverpod/state_provider.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String image;

  const CategoryItem({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => InkWell(
        onTap: () {
          log(title);
          ref.read(categoryProvider.state).state = title;
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
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
