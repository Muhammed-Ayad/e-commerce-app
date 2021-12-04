import 'package:flutter/material.dart';

import '../../../blocs/model/user_model.dart';
import './edit_profile_screen.dart';

class UserItem extends StatelessWidget {
  final UserModel userModel;
  final String docsid;

  const UserItem({Key? key, required this.userModel, required this.docsid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height - 120;
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User Name : ${userModel.userName}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.teal
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Email : ${userModel.email}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.pink
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        docsid: docsid,
                        userModel: userModel,
                      ),
                    ),
                  );
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
                        'Edit ',
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
                      Icons.edit,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
