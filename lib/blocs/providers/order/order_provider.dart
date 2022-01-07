import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/remote/dio_client.dart';
import '../../models/cart_model.dart';
import '../../models/orders_model.dart';
import './order_state.dart';

final orderItemProvider =
    StateNotifierProvider<OrderProvider, OrderState>((ref) {
  return OrderProvider();
});

class OrderProvider extends StateNotifier<OrderState> {
  OrderProvider() : super(OrderInitial([])) {
    getOrdersItems();
  }

  void getOrdersItems() {
    try {
      state = OrderLoading();
      final List<OrderModel> orders = [];
      state = OrderLoaded(orders);
    } catch (e) {
      state = OrderError('You Have Error');
    }
  }

  Future<void> fetchAndSetOrders([bool filterByUser = false]) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final filterString = filterByUser
          ? 'orderBy="id"&equalTo="$userId"'
          : 'orderBy="id"&equalTo="$userId"';

      final data = await DioClient()
          .send(reqMethod: 'get', path: 'orders.json?$filterString');
      final List<OrderModel> loadedOrders = [];
      final extractedData = data.data;
      final List<OrderModel> orders;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderModel(
            id: FirebaseAuth.instance.currentUser!.uid,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartModel(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ),
                )
                .toList(),
          ),
        );
      });

      orders = loadedOrders.reversed.toList();
      state = OrderLoaded(orders);
    } on SocketException {
      log('SocketException');
    } on FormatException {
      log('FormatException');
    } catch (err) {
      log(err.toString());
    }
  }

  Future<void> addOrder(List<CartModel> cartProducts, double total,
      List<OrderModel> orders) async {
    try {
      final timestamp = DateTime.now();
      final data =
          await DioClient().send(reqMethod: 'post', path: 'orders.json', body: {
        'id': FirebaseAuth.instance.currentUser!.uid,
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      });
      orders.insert(
        0,
        OrderModel(
          id: json.decode(data.data)['name'],
          amount: total,
          dateTime: timestamp,
          products: cartProducts,
        ),
      );
    } catch (err) {
      log(err.toString());
    }
  }
}
