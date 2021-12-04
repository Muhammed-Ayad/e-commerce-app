import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/riverpod/state_provider.dart';
import './brands.dart';

class BrandItem extends StatelessWidget {
  final String title;
  final String image;

  const BrandItem({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Card(
        elevation: 6,
        child: InkWell(
          onTap: () {
            log(title);
            ref.read(brandProvider.state).state = title;
            Navigator.pushNamed(context, Brands.id);
          },
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
