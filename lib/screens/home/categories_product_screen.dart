import '../home/products_screen.dart';
import 'package:provider/provider.dart';

import '../../model/category_model.dart';
import 'package:flutter/material.dart';

class CategoriesProductScreen extends StatefulWidget {
  @override
  _CategoriesProductScreenState createState() => _CategoriesProductScreenState();
}

class _CategoriesProductScreenState extends State<CategoriesProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Consumer<DUMMYCATEGORIES>(
        builder: (context, categoryitems, child) => GridView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          itemCount: categoryitems.items.length,
          itemBuilder: (context, i) {
            return CategoryItem(
              image: categoryitems.items[i].image,
              title: categoryitems.items[i].title,
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3 / 6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String image;

  CategoryItem({
    required this.title,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductsScreen.id,
          arguments: title,
        );
      },
      child: Container(
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: Container(
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
