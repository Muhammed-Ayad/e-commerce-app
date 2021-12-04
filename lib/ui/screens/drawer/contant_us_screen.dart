import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/locale_keys.g.dart';
class ContantUsScreen extends StatefulWidget {
  static const id = 'ContantUsScreen';
  const ContantUsScreen({Key? key}) : super(key: key);

  @override
  _ContantUsScreenState createState() => _ContantUsScreenState();
}

class _ContantUsScreenState extends State<ContantUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.contantUs.tr(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Card(
          color: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    LocaleKeys.welcome.tr(),
                    style: const TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      socialButtons(
                          color: Colors.green,
                          icon: FontAwesome.linkedin,
                          function: () {
                            _openWhatsAppChat();
                          }),
                      socialButtons(
                          color: Colors.red,
                          icon: Icons.mail_outline_outlined,
                          function: () {
                            _mailTo();
                          }),
                      socialButtons(
                          color: Colors.purple,
                          icon: Icons.call_outlined,
                          function: () {
                            _callPhoneNumber();
                          }),
                      socialButtons(
                        color: Colors.red,
                        icon: FontAwesome.facebook,
                        function: () {
                          _facebook();
                        },
                      ),
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

  void _openWhatsAppChat() async {
    var whatsappUrl = 'https://www.linkedin.com/in/mohamed-ayad1998/';
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Error occured coulnd\'t open link';
    }
  }

  void _mailTo() async {
    var url = 'mailto:mohamedabdo333334@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error occured coulnd\'t open link';
    }
  }

  void _callPhoneNumber() async {
    var phoneUrl = 'tel://01282903069';
    if (await canLaunch(phoneUrl)) {
      launch(phoneUrl);
    } else {
      throw "Error occured coulnd\'t open link";
    }
  }

  void _facebook() async {
    var phoneUrl = 'https://www.facebook.com/mohamed.abdo1998/';
    if (await canLaunch(phoneUrl)) {
      launch(phoneUrl);
    } else {
      throw "Error occured coulnd\'t open link";
    }
  }

  Widget socialButtons(
      {required Color color,
      required IconData icon,
      required Function function}) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        radius: 23,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(
            icon,
            color: color,
          ),
          onPressed: () {
            function();
          },
        ),
      ),
    );
  }
}
