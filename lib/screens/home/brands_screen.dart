import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/constants.dart';
import 'package:flutter/material.dart';

import 'details_screen.dart';

class BrandsScreen extends StatefulWidget {
  static const id = 'BrandsScreen';
  @override
  _BrandsScreenState createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  CollectionReference _productColl =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(routeArgs),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
         future: _productColl.where('brand', isEqualTo: routeArgs).get(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
               return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
            }
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                        child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, i) => BrandsItems(
                            imageUrl: snapshot.data.docs[i]['image'],
                            title: snapshot.data.docs[i]['title'],
                            price: snapshot.data.docs[i]['price'],
                            id: snapshot.data.docs[i]['id'],
                            brand: snapshot.data.docs[i]['brand'],
                            category: snapshot.data.docs[i]['category'],
                            description: snapshot.data.docs[i]['description'],
                            quantity: snapshot.data.docs[i]['quantity'],
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          },
        ),
      ),
    );
  }
}


class BrandsItems extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String quantity;
  final String description;
  final String category;
  final String brand;
  final String id;

  BrandsItems({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.id,
    required this.quantity,
    required this.description,
    required this.category,
    required this.brand,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      height: 190.0,
      child: InkWell(
        onTap: () {
         Navigator.of(context).pushNamed(
            DetailsScreen.ronteName,
            arguments: {
               'id':id,
              'image': imageUrl,
              'title': title,
              'price': price,
              'quantity': quantity,
              'description': description,
              'brand':brand,
              'category':category,
            },
          );
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 166.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 25,
                      color: Colors.black12),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 160.0,
                width: 200.0,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              child: SizedBox(
                height: 136.0,
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding / 5, 
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text('\$${price.toString()}'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



