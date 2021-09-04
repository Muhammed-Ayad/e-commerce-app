import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ButtonClickHereWidget extends StatelessWidget {
  final VoidCallback onPressed;
  ButtonClickHereWidget({
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: "if you have Account ? ",
            style: Theme.of(context).textTheme.headline1,
          ),
          TextSpan(),
          TextSpan(
              text: "Click Here",
              style: Theme.of(context).textTheme.headline2,
              recognizer: TapGestureRecognizer()..onTap = () => onPressed(),),
        ]),
      ),
    );
  }
}
