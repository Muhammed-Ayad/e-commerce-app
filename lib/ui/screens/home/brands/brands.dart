import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../blocs/model/product.dart';
import '../../../../services/firebase/firestore_service.dart';
import '../../../../services/riverpod/state_provider.dart';
import '../../../../themes/colors.dart';
import '../product/product_item.dart';

class Brands extends StatelessWidget {
   static const id = 'Brands';
  const Brands({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final brandName = ref.watch(brandProvider);
        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            elevation: 0,
            title: Text(brandName!),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: FirestoreService.getCollectionProducts
                .where('brand', isEqualTo: brandName)
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
                                  product: Product.fromJson(
                                    snapshot.data.docs[i],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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
        );
      },
    );
  }
}
