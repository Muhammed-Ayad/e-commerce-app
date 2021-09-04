import '../constants/constants.dart';
import 'cart/order_screen.dart';
import 'profile/profile_screen.dart';
import 'home/home_page_screen.dart';
import 'package:flutter/material.dart';

class TapScreen extends StatefulWidget {
  @override
  _TapScreenState createState() => _TapScreenState();
}

class _TapScreenState extends State<TapScreen> {
  int _seletedPageIndex = 0;
  final List<Map<String, Widget>> _pages = [
    {
      'page': HomePageScreen(),
      'title': Text('E-Commerce-App'),
    },
    {
      'page': OrderScreen(),
      'title': Text('Cart'),
    },
    {
      'page': ProfileScreen(),
      'title': Text('Profile'),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
