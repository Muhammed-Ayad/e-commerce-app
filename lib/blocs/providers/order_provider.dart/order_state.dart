import '../../model/orders_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {
  final List<OrderModel> orderModel;
  OrderInitial(this.orderModel);
}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}
