import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import '../../model/cart_provider.dart';
import '../cart/cart_widget.dart';
import '../home/categories_product_screen.dart';
import '../cart/badge.dart';
import '../../widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'category_brands_screen.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
     final cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("E-Commerce-App"),
        centerTitle: true,
        elevation: 6,
        actions: [
            Badge(
              value: cartProvider.itemCount.toString(),
              color: Colors.red,
              child: IconButton(
                icon: Icon(
                  FontAwesome.shopping_basket,
                  color: Colors.amber,
                ),
                onPressed: () {
                   Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Carousel(
              indicatorBgPadding: 5.0,
              dotPosition: DotPosition.bottomCenter,
              showIndicator: true,
              dotIncreaseSize: 2,
              dotSpacing: 20,
              dotColor: Colors.white,
              dotBgColor: Colors.black.withOpacity(0.2),
              autoplay: true,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 5.0,
              dotIncreasedColor: Colors.purple,
              boxFit: BoxFit.cover,
              images: [
                Image.asset('assets/images/carousel1.png'),
                Image.asset('assets/images/carousel4.png'),
                Image.asset('assets/images/carousel4.png'),
              ],
            ),
          ),
          //===================================================

          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadlineItem(
                title: 'Categories',
              ),
              HeadlineItem(
                title: '>>',
              ),
            ],
          ),

          CategoriesProductScreen(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadlineItem(
                title: 'Brands',
              ),
              HeadlineItem(
                title: '>>',
              ),
            ],
          ),
          CategoryBrandsScreen()
        ],
      ),
    );
  }
}

class HeadlineItem extends StatelessWidget {
  final String title;
  HeadlineItem({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
