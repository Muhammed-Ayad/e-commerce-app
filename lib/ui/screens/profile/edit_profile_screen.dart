import 'package:flutter/material.dart';

import '../../widgets/space_widget.dart';
import '../../../blocs/models/user_model.dart';
import '../../../services/firebase/firestore_service.dart';
import '../../widgets/scaffold_message.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userModel;
  final String docsid;

  const EditProfileScreen(
      {Key? key, required this.userModel, required this.docsid})
      : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final myEmailController = TextEditingController();
  final myNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    myEmailController.text = widget.userModel.email;
    myNameController.text = widget.userModel.userName;
    super.initState();
  }

  editProfile() {
    var formData = _formKey.currentState;
    if (formData!.validate()) {
      formData.save();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
                  title: '    Email',
                ),
                TextFormField(
                  controller: myEmailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'please Enter Email';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'ex : mohamed@gmail.com',
                  ),
                ),
                SpaceAndTitleWidget(
                  title: '    UserName',
                ),
                TextFormField(
                  controller: myNameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'please Enter UserName';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'ex : Mohamed-Ayad',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: loading
          ? const CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: () async {
                if (myEmailController.text == "" ||
                    myNameController.text == "") {
                  Utils.customMessage(
                      context, "All fields are required!", Colors.redAccent);
                } else {
                  setState(() {
                    loading = true;
                  });
                  await FirestoreService.updatetUser(
                    email: myEmailController.text,
                    userName: myNameController.text,
                    docId: widget.docsid,
                  );
                  setState(() {
                    loading = false;
                  });
                }
                Navigator.pop(context);
              },
              child: const Icon(Icons.save),
            ),
    );
  }
}
