import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widgets/global_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/button_auth_widget.dart';
import '../../widgets/button_chick_here_widget.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController _fullnameTextController =
      TextEditingController(text: '');
  late TextEditingController _emailTextController =
      TextEditingController(text: '');
  late TextEditingController _passTextController =
      TextEditingController(text: '');
  bool _isLoading = false;
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullnameTextController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();

    super.dispose();
  }

 void _submitFormOnSignUp() async {
    final isValid = _signUpFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        final String userId = _auth.currentUser!.uid;

        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'id': userId,
          'name': _fullnameTextController.text,
          'email': _emailTextController.text,
        });
        Navigator.of(context).pushReplacementNamed('topview');
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethods.showErrorDialog(
          error: error.toString(),
          context: context,
        );
        print('erorrrr occured $error');
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
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _signUpFormKey,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.perm_identity),
                        hintText: 'UserName',
                      ),
                      controller: _fullnameTextController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please write the username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                      ),
                      controller: _emailTextController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid Email adress';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black45,
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                      controller: _passTextController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ButtonClickHereWidget(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('login');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                   _isLoading
                  ? Center(
                      child: Container(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  :  ButtonAuthWidget(
                      title: 'SignUp',
                      onPressed: _submitFormOnSignUp,
                      iconData: Icons.person_add,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
