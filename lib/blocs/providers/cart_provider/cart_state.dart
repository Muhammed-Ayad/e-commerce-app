import '../../model/cart_model.dart';


abstract class CartState {}

class CartInitial extends CartState {
  CartInitial(this.cartItems);
  final List<CartModel> cartItems;
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
    CartLoaded(this.cartItems);
  final List<CartModel> cartItems;
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
