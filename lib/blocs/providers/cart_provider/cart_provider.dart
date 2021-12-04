import 'package:flutter_riverpod/flutter_riverpod.dart';

import './cart_state.dart';
import '../../model/cart_model.dart';

final cartItemProvider = StateNotifierProvider<CartProvider, CartState>((ref) {
  return CartProvider();
});

class CartProvider extends StateNotifier<CartState> {
  CartProvider() : super(CartInitial([])) {
    getCartItems();
  }

  void getCartItems() {
    try {
      state = CartLoading();

      final List<CartModel> cartItems = [];
      state = CartLoaded(cartItems);
    } catch (e) {
      state = CartError('You Have Error');
    }
  }

  int itemCount(List<CartModel> cartModel) {
    return cartModel.length;
  }

  double totalAmount(List<CartModel> cartModel) {
    var total = 0.0;
    for (var cartItem in cartModel) {
      total += cartItem.price * cartItem.quantity;
    }
    return total;
  }

  void clearItemCart(List<CartModel> cartItems) {
    state = CartLoaded(cartItems);
    cartItems.clear();
  }

  void addItem(
      String productId, double price, String title, List<CartModel> cartItems) {
    cartItems
        .add(CartModel(id: productId, price: price, quantity: 1, title: title));
    state = CartLoaded(cartItems);
  }
}
