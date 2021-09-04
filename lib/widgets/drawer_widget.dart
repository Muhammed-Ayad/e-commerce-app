import 'package:e_commerce/screens/home/contant_us_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/auth/user_state.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Colors.cyan),
            child: Column(
              children: [
                Flexible(
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                    child: Text(
                  'E-Commerce-App',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontStyle: FontStyle.italic),
                ))
              ],
            )),
        SizedBox(
          height: 30,
        ),
        _listTiles(
            label: 'Contant us',
            function: () {
              _navigateToTaskScreen(context);
            },
            icon: Icons.contact_page),
        Divider(
          thickness: 1,
        ),
        _listTiles(
            label: 'Logout',
            function: () {
              _logout(context);
            },
            icon: Icons.logout_outlined),
      ],
    ));
  }

  void _navigateToTaskScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContantUsScreen(),
      ),
    );
  }

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://image.flaticon.com/icons/png/128/1252/1252006.png',
                    height: 20,
                    width: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sign out'),
                ),
              ],
            ),
            content: Text(
              'Do you wanna Sign out',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Cancel'),
              ),
              TextButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => UserState(),
                      ),
                    );
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          );
        });
  }

  Widget _listTiles(
      {required String label,
      required Function function,
      required IconData icon}) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Icon(
        icon,
        color: Colors.pink.shade500,
      ),
      title: Text(
        label,
        style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      ),
    );
  }
}
