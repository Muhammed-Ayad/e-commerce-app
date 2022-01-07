import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Carousel(
        indicatorBgPadding: 0.0,
        dotPosition: DotPosition.bottomCenter,
        showIndicator: true,
        dotSpacing: 7,
        dotBgColor: Colors.transparent,
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: const Duration(milliseconds: 1000),
        dotSize: 5.0,
        boxFit: BoxFit.fill,
        images: [
          Image.asset('assets/images/carousel4.png'),
          Image.asset('assets/images/carousel4.png'),
        ],
      ),
    );
  }
}
