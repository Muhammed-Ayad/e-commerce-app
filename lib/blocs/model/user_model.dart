import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userName;
  final String email;
  final String userId;

  UserModel({
    required this.userName,
    required this.email,
    required this.userId,
  });

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      userName: snapshot['name'],
      email: snapshot['email'],
      userId: snapshot['id'],
    );
  }
}
