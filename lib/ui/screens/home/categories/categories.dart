import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../blocs/models/product_model.dart';
import '../../../../services/firebase/firestore_service.dart';
import '../../../../services/riverpod/state_provider.dart';
import '../../../../themes/colors.dart';
import '../product/product_item.dart';

class Categories extends StatelessWidget {
       static const id = 'Categories';

  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final categoryName = ref.watch(categoryProvider);

        return Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
            elevation: 0,
            title: Text(categoryName!),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: FirestoreService.getCollectionProducts
                .where('category', isEqualTo: categoryName)
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
