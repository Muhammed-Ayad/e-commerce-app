import 'package:flutter/material.dart';
import 'add_product.dart';
import 'address_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Mohamed'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            CardPageItem(
              icon: Icons.location_on,
              title: 'Address',
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddressScreen(),
                  ),
                );
              },
            ),
          
            CardPageItem(
              icon: Icons.manage_accounts,
              title: 'Edit Profile',
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed('EditProfile');
              },
            ),
            CardPageItem(
              icon: Icons.favorite,
              title: 'Favorite',
              color: Colors.purple,
              onPressed: () {
                Navigator.of(context).pushNamed('Favorites');
              },
            ),
           
            CardPageItem(
              icon: Icons.upload,
              title: 'Upload Product',
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UploadProductForm(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardPageItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  CardPageItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        onTap: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(title),
        trailing: Icon(Icons.double_arrow),
      ),
    );
  }
}
