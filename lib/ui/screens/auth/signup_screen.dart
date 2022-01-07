import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../themes/text_styles.dart';
import '../../widgets/button_auth_widget.dart';
import '../../widgets/button_chick_here_widget.dart';
import '../../../services/firebase/auth_service.dart';
import '../../../services/firebase/firestore_service.dart';
import '../../../services/validators/validators_auth.dart';
import '../tap_screen.dart';
import './login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const id = 'SignUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool loading = false;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Hero(
                      tag: 'imageHero',
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: Image.asset("assets/images/logo.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: kTextFormStyle,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.perm_identity),
                        hintText: LocaleKeys.userName.tr(),
                      ),
                      controller: _nameController,
                      validator: ValidarorsAuth.nameValidator,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: kTextFormStyle,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: LocaleKeys.email.tr(),
                      ),
                      controller: _emailController,
                      validator: ValidarorsAuth.emailValidator,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: kTextFormStyle,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      obscureText: _obscureText,
                      decoration: textFormDecorationPassword(),
                      controller: _passwordController,
                      validator: ValidarorsAuth.passwordValidator,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     ButtonToVerifyThatYouHaveAnAccount(
                      pageName: const LoginScreen(),
                      title: LocaleKeys.youHave.tr(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        // * Create a new account and save user data
                        : AuthButton(
                            title: LocaleKeys.signup.tr(),
                            iconData: Icons.person_add,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                User? result = await AuthService.signUp(
                                  _emailController.text,
                                  _passwordController.text,
                                  context,
                                );
                                await FirestoreService.insertUser(
                                  email: _emailController.text,
                                  userName: _nameController.text,
                                );

                                if (result != null) {
                                  Navigator.pushReplacementNamed(
                                      context, TapScreen.id);
                                }
                              }
                              setState(() {
                                loading = false;
                              });
                            },
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

  InputDecoration textFormDecorationPassword() {
    return InputDecoration(
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.black45,
        ),
      ),
      prefixIcon: const Icon(Icons.lock),
      hintText: LocaleKeys.password.tr(),
    );
  }
}
