import 'package:json_annotation/json_annotation.dart';

import './cart_model.dart';
part './orders_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String id;
  final double amount;
  final List<CartModel> products;
  final DateTime dateTime;
  OrderModel({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
Map<String, dynamic> toJson() => _$OrderModelToJson(this);
 
}
