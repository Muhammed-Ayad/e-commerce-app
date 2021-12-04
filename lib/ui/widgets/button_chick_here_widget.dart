import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';

class ButtonToVerifyThatYouHaveAnAccount extends StatelessWidget {
  final Widget pageName;
  final String title;

  const ButtonToVerifyThatYouHaveAnAccount(
      {Key? key, required this.pageName, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: FittedBox(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.headline1,
            ),
            const TextSpan(text: ' '),
            TextSpan(
              text: LocaleKeys.checkHere.tr(),
              style: Theme.of(context).textTheme.headline2,
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pageName,
                      ),
                    ),
            ),
          ]),
        ),
      ),
    );
  }
}
