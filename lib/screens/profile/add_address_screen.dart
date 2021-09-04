import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/space_widget.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController _addressOneController = TextEditingController();
  TextEditingController _addressTwoController = TextEditingController();

  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _cityNameController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _addressOneController.dispose();
    _addressTwoController.dispose();
    _phoneNumberController.dispose();
    _cityNameController.dispose();
    _fullNameController.dispose();
  }

  void _newAddress() async {
    String _uid = _auth.currentUser!.uid;
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      final taskID = Uuid().v4();
      try {
        await FirebaseFirestore.instance.collection('address').doc(taskID).set({
          'taskId': taskID,
          'uploadedBy': _uid,
          'addressOne': _addressOneController.text.trim(),
          'addressTwo': _addressTwoController.text.trim(),
          'phoneNumber': _phoneNumberController.text.trim(),
          'cityName': _cityNameController.text.trim(),
          'fullName': _fullNameController.text.trim(),
          'createdAt': Timestamp.now(),
          
        });
        Fluttertoast.showToast(
            msg: "Address has been uploaded successfuly",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            fontSize: 16.0);
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print('Form not valid');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(13),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceAndTitleWidget(
                  title: '    Address 1',
                ),
                TextFormField(
                  controller: _addressOneController,
                  validator: (val) {
                    if (val!.isEmpty || val.length < 2) {
                      return 'please Enter Address 1';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'ex : street',
                  ),
                ),
                SpaceAndTitleWidget(
                  title: '    Address 2',
                ),
                TextFormField(
                  controller: _addressTwoController,
                  validator: (val) {
                    if (val!.isEmpty || val.length < 2) {
                      return 'please Enter Address 2';
                    }
                     return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'ex : street',
                  ),
                ),
                SpaceAndTitleWidget(
                  title: '    Phone Number',
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  validator: (val) {
                    if (val!.isEmpty || val.length < 2) {
                      return 'please Enter Phone Number';
                    } return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'ex : 0105555555',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SpaceAndTitleWidget(
                  title: '   City Name',
                ),
                TextFormField(
                  controller: _cityNameController,
                  validator: (val) {
                    if (val!.isEmpty || val.length < 2) {
                      return 'please Enter City Name';
                    } return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'ex : Damietta',
                  ),
                ),
                SpaceAndTitleWidget(
                  title: '   Name',
                ),
                TextFormField(
                  controller: _fullNameController,
                  validator: (val) {
                    if (val!.isEmpty || val.length < 2) {
                      return 'please Enter Name';
                    } return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'ex : Mohamed',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? Center(
                        child: Container(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : MaterialButton(
                        onPressed: _newAddress,
                        color: Colors.pink.shade700,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side: BorderSide.none),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                'New Addres',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
