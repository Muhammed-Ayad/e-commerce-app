import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../ui/widgets/scaffold_message.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;

  static Future<User?> signUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Utils.customMessage(context, e.message.toString(), Colors.redAccent);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<User?> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Utils.customMessage(context, e.message.toString(), Colors.redAccent);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<User?> signOut(BuildContext context) async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      Utils.customMessage(context, e.message.toString(), Colors.redAccent);
    } catch (e) {
      log(e.toString());
    }
  }
}
