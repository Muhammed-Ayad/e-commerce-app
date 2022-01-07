import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../blocs/models/user_model.dart';
import '../../../services/firebase/auth_service.dart';
import './user_item.dart';

class UserInfo extends StatelessWidget {
               static const id = 'UserInfo';

  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(LocaleKeys.infoUser.tr(),),
        centerTitle: true,
     
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: AuthService.auth.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('You Have Error'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return UserItem(
                  userModel: UserModel.fromJson(snapshot.data.docs[index]),
                  docsid: snapshot.data.docs[index].id,
                );
              },
            );
          }
          return const Center(
            child: Text('No data avialiable'),
          );
        },
      ),
    
    );
  }
}
