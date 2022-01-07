import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../blocs/models/product_model.dart';
import '../../../services/firebase/firestore_service.dart';
import '../home/product/product_item.dart';

class FavoriteScreen extends StatefulWidget {
             static const id = 'FavoriteScreen';

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String? idProduct;
  Future getSharedPre() async {
    var sharedPref = await SharedPreferences.getInstance();
    final String? value = sharedPref.getString(
      'idPrefer',
    );
    return value;
  }

  @override
  void initState() {
    getSharedPre().then((value) {
      setState(() {
        idProduct = value;
        log(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: FirestoreService.getCollectionProducts
              .where('id', isEqualTo: idProduct)
              .get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
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
                          margin: const EdgeInsets.only(top: 70),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, i) {
                            return ProductItem(
                              product: ProductModel.fromJson(
                                snapshot.data.docs[i],
                              ),
                            );
                          },
                        ),
                      ],
                    ))
                  ],
                ),
              );
            }
            return const Center(
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
