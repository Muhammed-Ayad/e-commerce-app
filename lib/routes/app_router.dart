import 'package:flutter/material.dart';

import '../ui/screens/auth/forget_password.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/signup_screen.dart';
import '../ui/screens/cart/cart_screen.dart';
import '../ui/screens/cart/orders_screen.dart';
import '../ui/screens/drawer/contant_us_screen.dart';
import '../ui/screens/home/brands/brands.dart';
import '../ui/screens/home/brands/brands_scroll_horizontal.dart';
import '../ui/screens/home/brands/brands_scroll_vertical.dart';
import '../ui/screens/home/categories/categories.dart';
import '../ui/screens/home/categories/categories_scroll_horizontal.dart';
import '../ui/screens/home/categories/categories_scroll_vertical.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/profile/add_address_screen.dart';
import '../ui/screens/profile/add_product.dart';
import '../ui/screens/profile/address_screen.dart';
import '../ui/screens/profile/favorite_screen.dart';
import '../ui/screens/profile/profile_screen.dart';
import '../ui/screens/profile/user_info.dart';
import '../ui/screens/tap_screen.dart';
import '../ui/screens/auth/user_state.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ForgetPassword.id: (ctx) => const ForgetPassword(),
  LoginScreen.id: (ctx) => const LoginScreen(),
  SignUpScreen.id: (ctx) => const SignUpScreen(),
  CartScreen.id: (ctx) => const CartScreen(),
  OrderScreen.id: (ctx) => const OrderScreen(),
  ContantUsScreen.id: (ctx) => const ContantUsScreen(),
  BrandsScrollHorizontal.id: (ctx) => const BrandsScrollHorizontal(),
  BrandsScrollVertical.id: (ctx) => const BrandsScrollVertical(),
  Brands.id: (ctx) => const Brands(),
  CategoriesScrollHorizontal.id: (ctx) => const CategoriesScrollHorizontal(),
  CategoriesScrollVertical.id: (ctx) => const CategoriesScrollVertical(),
  Categories.id: (ctx) => const Categories(),
  HomeScreen.id: (ctx) => const HomeScreen(),
  AddAddressScreen.id: (ctx) => const AddAddressScreen(),
  UploadProductForm.id: (ctx) => const UploadProductForm(),
  AddressScreen.id: (ctx) => const AddressScreen(),
  FavoriteScreen.id: (ctx) => const FavoriteScreen(),
  ProfileScreen.id: (ctx) => const ProfileScreen(),
  UserInfo.id: (ctx) => const UserInfo(),
  TapScreen.id: (ctx) => const TapScreen(),
  UserState.id:(ctx)=>const UserState(),
};
