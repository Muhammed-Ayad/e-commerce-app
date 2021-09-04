import '../../model/brand_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'brands_screen.dart';

class CategoryBrandsScreen extends StatefulWidget {
  @override
  _CategoryBrandsScreenState createState() => _CategoryBrandsScreenState();
}

class _CategoryBrandsScreenState extends State<CategoryBrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Consumer<DUMMYBRANDS>(
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
    return Expanded(
      child: Card(
        elevation: 6,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              BrandsScreen.id,
              arguments: title,
            );
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
