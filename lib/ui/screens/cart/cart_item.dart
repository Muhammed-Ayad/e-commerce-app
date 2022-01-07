import 'package:flutter/material.dart';

import '../../../blocs/models/cart_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, this.cartModel}) : super(key: key);

  final List<CartModel>? cartModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: cartModel!.length,
      itemBuilder: (context, i) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$${cartModel![i].price}'),
                ),
              ),
            ),
            title: Text(cartModel![i].title),
            subtitle: Text('\$${cartModel![i].price * cartModel![i].quantity}'),
            trailing: Text('${cartModel![i].quantity} x'),
          ),
        ),
      ),
    );
  }
}
