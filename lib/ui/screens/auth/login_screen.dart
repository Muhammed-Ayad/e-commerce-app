import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../generated/locale_keys.g.dart';
import '../../../themes/text_styles.dart';
import '../../widgets/button_auth_widget.dart';
import '../../widgets/button_chick_here_widget.dart';
import '../../../services/firebase/auth_service.dart';
import '../../../services/validators/validators_auth.dart';
import '../tap_screen.dart';
import './signup_screen.dart';
import './forget_password.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool loading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: textFormDecorationPassword(),
                  controller: _passwordController,
                  validator: ValidarorsAuth.passwordValidator,
                ),
                const SizedBox(
                  height: 10,
                ),
                 ButtonToVerifyThatYouHaveAnAccount(
                  pageName: const SignUpScreen(),
                  title: LocaleKeys.dontHave.tr(),
                ),
                const SizedBox(
                  height: 10,
                ),
                loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    // * login button
                    : AuthButton(
                        title: LocaleKeys.login.tr(),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            User? result = await AuthService.login(
                              _emailController.text,
                              _passwordController.text,
                              context,
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
                        iconData: Icons.login,
                      ),
                const SizedBox(
                  height: 12,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgetPassword.id);
                  },
                  child:  Text(
                    LocaleKeys.iForgot.tr(),
                    style: const TextStyle(fontSize: 18, color: Colors.pink),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    )));
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
