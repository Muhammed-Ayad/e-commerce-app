import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../blocs/models/product_model.dart';
import '../../../../blocs/providers/cart/cart_provider.dart';
import '../../../../blocs/providers/cart/cart_state.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../themes/colors.dart';
import '../../../widgets/appbar_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final price = double.parse(widget.product.price);
    return Scaffold(
      appBar: buildAppBar(context),
      bottomSheet: Row(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 50,
              child: Consumer(builder: (context, ref, child) {
                final state = ref.watch(cartItemProvider);
                if (state is CartLoaded) {
                  return MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(side: BorderSide.none),
                    color: Colors.redAccent.shade400,
                    onPressed: () {
                      ref.watch(cartItemProvider.notifier).addItem(
                            widget.product.id,
                            price,
                            widget.product.title.toString(),
                            state.cartItems,
                          );
                    },
                    child: Text(
                      LocaleKeys.addToCart.tr(),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                }
                return const Center(child: Text('Loading...'));
              }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).disabledColor,
              height: 50,
              child: IconButton(
                onPressed: () async {
                  var sharedPref = await SharedPreferences.getInstance();

                  await sharedPref.setString('idPrefer', widget.product.id);
                },
                icon: const Icon(
                     Icons.favorite
                    ),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: size.height * 0.3,
                    child: Stack(
                      children: [
                        Container(
                          height: size.width * 0.7,
                          width: size.width * 0.7,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Image.network(
                          widget.product.imageUrl,
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
                      widget.product.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    '\$$price',
                    style: const TextStyle(
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
              margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 1.5,
                vertical: kDefaultPadding / 2,
              ),
              child: Text(
                widget.product.description,
                style: const TextStyle(color: Colors.white, fontSize: 19.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                thickness: 1,
                color: Colors.grey,
                height: 1,
              ),
            ),
            _details('Brand: ', widget.product.brand),
            const SizedBox(
              height: 15,
            ),
            _details('Quantity: ', widget.product.quantity),
            const SizedBox(
              height: 15,
            ),
            _details('Category: ', widget.product.category),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
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
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 21.0),
          ),
          Text(
            info,
            style: const TextStyle(
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
