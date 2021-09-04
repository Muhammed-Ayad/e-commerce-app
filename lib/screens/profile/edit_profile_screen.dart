import '../../widgets/space_widget.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var myEmail,myName,myPhone;

  editProfile(){
    var formData =_formKey.currentState;
    if(formData!.validate()){
      formData.save();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
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
                  title: '    Email',
                ),
                TextFormField(
                  onSaved: (value){
                    myEmail=value;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'please Enter Email';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'ex : mohamed@gmail.com',
                  ),
                ),
                SpaceAndTitleWidget(
                  title: '    UserName',
                ),
                TextFormField(
                  onSaved: (value){
                    myName=value;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'please Enter UserName';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'ex : Mohamed-Ayad',
                  ),
                ),
                SpaceAndTitleWidget(
                  title: '    Phone Number',
                ),
                TextFormField(
                  onSaved: (value){
                    myPhone=value;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'please Enter Phone Number';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'ex : 01055555555',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          editProfile();
        },
      ),
    );
  }
}
