import 'package:e_commerce_app/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import './brands/brands_scroll_horizontal.dart';
import './brands/brands_scroll_vertical.dart';
import './categories/categories_scroll_vertical.dart';
import '../../widgets/appbar_widget.dart';
import './categories/categories_scroll_horizontal.dart';
import '../../widgets/carousel_slider_widget.dart';
import '../../widgets/headline_title.dart';
import '../../widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
       static const id = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: buildAppBar(context),
      body: ListView(
        children: [
          // Special for displaying advertisements and discounts
          const CarouselSliderWidget(),
          const SizedBox(
            height: 20,
          ),

          // Categories
          HeadlineTitle(
            title: LocaleKeys.categories.tr(),
            context: context,
            screen: const CategoriesScrollVertical(),
          ),

          const CategoriesScrollHorizontal(),

      

          // Brands
          HeadlineTitle(
            title: LocaleKeys.brands.tr(),
            context: context,
            screen: const BrandsScrollVertical(),
          ),

          const BrandsScrollHorizontal(),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
