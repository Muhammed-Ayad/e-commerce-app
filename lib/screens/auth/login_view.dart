import 'package:e_commerce/widgets/global_method.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/button_auth_widget.dart';
import '../../widgets/button_chick_here_widget.dart';

class LogInView extends StatefulWidget {
  @override
  _LogInViewState createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController _emailTextController =
      TextEditingController(text: '');
  late TextEditingController _passTextController =
      TextEditingController(text: '');
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();

    super.dispose();
  }

  void _submitFormOnLogIn() async {
    final isValid = _loginFormKey.currentState!.validate();
   
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
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
    Size? size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: size.height * 0.10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _loginFormKey,
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
                      keyboardType: TextInputType.visiblePassword,
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
                    ButtonClickHereWidget(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('signup');
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
                        : ButtonAuthWidget(
                            title: 'LogIn',
                            onPressed: _submitFormOnLogIn,
                            iconData: Icons.login,
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
