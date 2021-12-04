import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../widgets/space_widget.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../services/firebase/firestore_service.dart';

class AddAddressScreen extends StatefulWidget {
         static const id = 'AddAddressScreen';

  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _addressOneController = TextEditingController();
  final _addressTwoController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _cityNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.addAddress.tr(),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(13),
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
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
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
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
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
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'ex : Mohamed',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? const Center(
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });

                            await FirestoreService.addAddres(
                              addressOne: _addressOneController.text,
                              addressTwo: _addressTwoController.text,
                              phoneNumber: _phoneNumberController.text,
                              cityName: _cityNameController.text,
                              fullName: _fullNameController.text,
                            );
                            Navigator.pop(context);
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        color: Colors.pink.shade700,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side: BorderSide.none),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
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
