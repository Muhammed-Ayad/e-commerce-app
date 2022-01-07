import 'package:e_commerce_app/ui/screens/home/search_screen.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttericon/font_awesome_icons.dart';

import '../../blocs/providers/cart/cart_provider.dart';
import '../../blocs/providers/cart/cart_state.dart';
import '../../generated/locale_keys.g.dart';
import '../screens/cart/cart_screen.dart';
import './badge.dart';

PreferredSizeWidget buildAppBar(context) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text(
      LocaleKeys.title.tr(),
    ),
    centerTitle: true,
    elevation: 6,
    actions: [
      IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchScreen()));
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          )),
      Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(cartItemProvider);
          if (state is CartLoaded) {
            return Badge(
              value: ref
                  .read(cartItemProvider.notifier)
                  .itemCount(state.cartItems)
                  .toString(),
              color: Colors.red,
              child: IconButton(
                icon: const Icon(
                  FontAwesome.shopping_basket,
                  color: Colors.amber,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.id);
                },
              ),
            );
          }
          return Badge(
            value: '0',
            color: Colors.red,
            child: IconButton(
              icon: const Icon(
                FontAwesome.shopping_basket,
                color: Colors.amber,
              ),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.id);
              },
            ),
          );
        },
      ),
    ],
  );
}
