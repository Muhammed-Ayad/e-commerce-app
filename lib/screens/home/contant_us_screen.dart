import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContantUsScreen extends StatefulWidget {
  @override
  _ContantUsScreenState createState() => _ContantUsScreenState();
}

class _ContantUsScreenState extends State<ContantUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contant US'),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 3,
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple
                  
                ),
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
                      fct: () {
                        _openWhatsAppChat();
                      }),
                  socialButtons(
                      color: Colors.red,
                      icon: Icons.mail_outline_outlined,
                      fct: () {
                        _mailTo();
                      }),
                  socialButtons(
                      color: Colors.purple,
                      icon: Icons.call_outlined,
                      fct: () {
                        _callPhoneNumber();
                      }),
                      socialButtons(
                      color: Colors.red,
                      icon: FontAwesome.facebook,
                      fct: () {
                        _facebook();
                      }),
                ],
              ),
            ),
          ],
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
      {required Color color, required IconData icon, required Function fct}) {
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
            fct();
          },
        ),
      ),
    );
  }
}
