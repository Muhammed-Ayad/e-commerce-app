import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../tap_screen.dart';
import './login_screen.dart';

class UserState extends StatelessWidget {
  static const id = 'UserState';
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: Text('Loading....'),
              ),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              log('TapScreen');
              return const TapScreen();
            } else {
              log('LoginScreen');
              return const LoginScreen();
            }
          } else if (userSnapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
