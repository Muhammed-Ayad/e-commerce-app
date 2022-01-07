import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../blocs/providers/order/order_provider.dart';
import '../../../blocs/providers/order/order_state.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../blocs/models/orders_model.dart';
import '../../widgets/drawer_widget.dart';

class OrderScreen extends StatelessWidget {
    static const id = 'OrderScreen';

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: Text(
            LocaleKeys.yourOrder.tr(),
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            return FutureBuilder(
              future: ref.read(orderItemProvider.notifier).fetchAndSetOrders(),
              builder: (cox, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.error != null) {
                    return const Center(
                      child: Text('Your Order'),
                    );
                  } else {
                    return Consumer(
                      builder: (context, ref, child) {
                        final ordersPro = ref.watch(orderItemProvider);
                        if (ordersPro is OrderLoaded) {
                          return ListView.builder(
                            itemCount: ordersPro.orders.length,
                            itemBuilder: (cox, index) =>
                                OrdersItem(order: ordersPro.orders[index]),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                  }
                }
              },
            );
          },
        ));
  }
}

class OrdersItem extends StatefulWidget {
  final OrderModel order;

  const OrdersItem({Key? key, required this.order}) : super(key: key);

  @override
  _OrdersItemState createState() => _OrdersItemState();
}

class _OrdersItemState extends State<OrdersItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd -MM -yyyy / hh:mm ').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.order.products.length * 20.0 + 10, 100),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prod.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${prod.quantity} x \$${prod.price}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
