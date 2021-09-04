import 'package:flutter/material.dart';

class GlobalMethods {
  static void showErrorDialog(
      {required String error, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://image.flaticon.com/icons/png/128/1252/1252006.png',
                  height: 20,
                  width: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Error occured'),
              ),
            ],
          ),
          content: Text(
            error,
            style: TextStyle(
                color: Color(0xFF00325A),
                fontSize: 20,
                fontStyle: FontStyle.italic),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text(
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

 