import 'package:flutter/material.dart';

class SpaceAndTitleWidget extends StatelessWidget {
  final String title;
  SpaceAndTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
