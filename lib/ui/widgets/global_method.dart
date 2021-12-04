import 'package:flutter/material.dart';

class GlobalMethods {
  static void showErrorDialog(
      {required String error, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error occured'),
          content: Text(
            error,
            style: const TextStyle(
                color: Color(0xFF00325A),
                fontSize: 20,
                fontStyle: FontStyle.italic),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        );
      },
    );
  }
}
