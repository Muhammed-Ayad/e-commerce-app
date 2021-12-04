import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';
import '../../themes/colors.dart';
import './profile/profile_screen.dart';
import './cart/orders_screen.dart';
import './home/home_screen.dart';

class TapScreen extends StatefulWidget {
  static const id = 'TapScreen';

  const TapScreen({Key? key}) : super(key: key);

  @override
  _TapScreenState createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  int _seletedPageIndex = 0;
  final List<Map<String, Widget>> _pages = [
    {
      'page': const HomeScreen(),
      'title': Text(
        LocaleKeys.homePage.tr(),
      ),
    },
    {
      'page': const OrderScreen(),
      'title': Text(
        LocaleKeys.cartPage.tr(),
      ),
    },
    {
      'page': const ProfileScreen(),
      'title': Text(
        LocaleKeys.profilePage.tr(),
      ),
    },
  ];

  void _selectPage(int index) {
    setState(() {
      _seletedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_seletedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        unselectedItemColor: kPrimaryColor,
        currentIndex: _seletedPageIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _selectPage,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: LocaleKeys.homePage.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: LocaleKeys.cartPage.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: LocaleKeys.profilePage.tr(),
          ),
        ],
      ),
    );
  }
}
