import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static get getCollectionProducts => _firestore.collection('products');

  static Future insertUser(
      {required String email, required String userName}) async {
    try {
      await _firestore.collection('users').add({
        "email": email,
        "id": _auth.currentUser!.uid,
        "name": userName,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  static Future updatetUser({
    required String email,
    required String userName,
    required String docId,
  }) async {
    try {
      await _firestore.collection('users').doc(docId).update({
        "email": email,
        "id": _auth.currentUser!.uid,
        "name": userName,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  static Future addAddres(
      {required String addressOne,
      required String addressTwo,
      required String phoneNumber,
      required String cityName,
      required String fullName}) async {
    try {
      final taskID = const Uuid().v4();
      await _firestore.collection('address').doc(taskID).set({
        'taskId': taskID,
        'uploadedBy': _auth.currentUser!.uid,
        'addressOne': addressOne.trim(),
        'addressTwo': addressTwo.trim(),
        'phoneNumber': phoneNumber.trim(),
        'cityName': cityName.trim(),
        'fullName': fullName.trim(),
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
