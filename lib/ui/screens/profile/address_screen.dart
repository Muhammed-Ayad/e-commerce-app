import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../profile/address_widget.dart';
import './add_address_screen.dart';
import '../../../generated/locale_keys.g.dart';

class AddressScreen extends StatefulWidget {
           static const id = 'AddressScreen';

  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          LocaleKeys.addressPage.tr(),
          style: const TextStyle(color: Colors.pink),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('address')
            .where(
              'uploadedBy',
              isEqualTo: _auth.currentUser!.uid,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AddressWidget(
                      address: snapshot.data!.docs[index]['addressOne'],
                      cityName: snapshot.data!.docs[index]['cityName'],
                      fullName: snapshot.data!.docs[index]['fullName'],
                      uploadedBy: snapshot.data!.docs[index]['uploadedBy'],
                      taskId: snapshot.data!.docs[index]['taskId'],
                    );
                  });
            } else {
              return const Center(
                child: Text('No address'),
              );
            }
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add_location_alt_outlined,
          color: Colors.red,
        ),
        onPressed: () {
          Navigator.pushNamed(
                                  context, AddAddressScreen.id);
         
        },
      ),
    );
  }
}
