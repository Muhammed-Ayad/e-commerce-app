import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartModel({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
 factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
