import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData iconData;

  const AuthButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.pink.shade700,
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13), side: BorderSide.none),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            iconData,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
