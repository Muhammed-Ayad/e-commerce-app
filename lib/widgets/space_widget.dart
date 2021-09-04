import 'package:flutter/material.dart';

class SpaceAndTitleWidget extends StatelessWidget {
  final String title;
  SpaceAndTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
