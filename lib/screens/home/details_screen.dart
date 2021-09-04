import '../../constants/constants.dart';
import '../../model/cart_provider.dart';
import '../../screens/cart/badge.dart';
import '../../screens/cart/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  static const ronteName = 'DetailsScreen';
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final listDetails = ModalRoute.of(context)!.settings.arguments as Map;
    final cartProvider = Provider.of<Cart>(context);
    final price = double.parse(listDetails['price']);

    return Scaffold(
      bottomSheet: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 50,
              child: MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(side: BorderSide.none),
                color: Colors.redAccent.shade400,
                onPressed: () {
                  cartProvider.addItem(
                    listDetails['id'],
                    price,
                    listDetails['title'].toString(),
                  );
                },
                child: Text(
                  'Add to Cart'.toUpperCase(),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).disabledColor,
              height: 50,
              child: InkWell(
                splashColor: Colors.red,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        actions: [
          Container(
            child: Badge(
              value: cartProvider.itemCount.toString(),
              color: Colors.red,
              child: IconButton(
                icon: Icon(
                  FontAwesome.shopping_basket,
                  color: Colors.amber,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(CartScreen.routeName, arguments: listDetails);
                },
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(
          color: kPrimaryColor,
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Text(
          listDetails['title'],
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: size.height * 0.3,
                    child: Stack(
                      children: [
                        Container(
                          height: size.width * 0.7,
                          width: size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Image.network(
                          listDetails['image'],
                          fit: BoxFit.fill,
                          height: size.width * 0.75,
                          width: size.width * 0.75,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      listDetails['title'],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    '\$${listDetails['price']}',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 1.5,
                vertical: kDefaultPadding / 2,
              ),
              child: Text(
                listDetails['description'],
                style: TextStyle(color: Colors.white, fontSize: 19.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
                height: 1,
              ),
            ),
            _details('Brand: ', listDetails['brand']),
            SizedBox(
              height: 15,
            ),
            _details('Quantity: ', listDetails['quantity']),
            SizedBox(
              height: 15,
            ),
            _details('Category: ', listDetails['category']),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _details(String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 21.0),
          ),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: Colors.lime,
            ),
          ),
        ],
      ),
    );
  }
}
