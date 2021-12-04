import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../blocs/model/cart_model.dart';
import '../../../blocs/providers/cart_provider/cart_provider.dart';
import '../../../blocs/providers/cart_provider/cart_state.dart';
import '../../../blocs/providers/order_provider.dart/order_provider.dart';
import '../../../blocs/providers/order_provider.dart/order_state.dart';
import '../../../generated/locale_keys.g.dart';
import './cart_item.dart';

class CartScreen extends StatelessWidget {
  static const id = 'CartScreen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.cartPage.tr(),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(cartItemProvider);
          if (state is CartInitial) {
            return buildInitialInput();
          } else if (state is CartLoading) {
            return buildLoading();
          } else if (state is CartLoaded) {
            final items = state.cartItems;
            return buildColumnWithData(items);
          } else {
            return buildInitialInput();
          }
        },
      ),
    );
  }
}

Widget buildInitialInput() {
  return const Center(
    child: Text('Initial...'),
  );
}

Widget buildLoading() {
  return const Center(
    child: Text('Loading.....'),
  );
}

Widget buildColumnWithData(List<CartModel> cartModel) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                const Spacer(),
                Chip(
                  backgroundColor: Colors.amber,
                  label: Consumer(
                    builder: (context, ref, child) => Text(
                      ref
                          .read(cartItemProvider.notifier)
                          .totalAmount(cartModel)
                          .toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const Expanded(child: OrderButton()),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListView(
          shrinkWrap: true,
          children: [
            CartItem(
              cartModel: cartModel,
            ),
          ],
        ),
      ],
    ),
  );
}

class OrderButton extends StatefulWidget {
  const OrderButton({Key? key}) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final ordersPro = ref.watch(orderItemProvider.notifier);
      final cartPro = ref.watch(cartItemProvider.notifier);
      final stateOrder = ref.watch(orderItemProvider);
      final stateCart = ref.watch(cartItemProvider);
      if (stateCart is CartLoaded) {
        if (stateOrder is OrderLoaded) {
          return MaterialButton(
            child: _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    LocaleKeys.orderNow.tr(),
                    style: const TextStyle(color: Colors.black)
                  ),
            onPressed:
                (cartPro.totalAmount(stateCart.cartItems) <= 0 || _isLoading)
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await ordersPro.addOrder(
                          stateCart.cartItems,
                          cartPro.totalAmount(stateCart.cartItems),
                          stateOrder.orders,
                        );
                        cartPro.clearItemCart(stateCart.cartItems);
                        setState(() {
                          _isLoading = false;
                        });
                      },
            textColor: Theme.of(context).primaryColor,
          );
        }
      }
      return const Center(child: Text('Loading...'));
    });
  }
}
