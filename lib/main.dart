import '/screens/cart/cart_widget.dart';
import '/screens/profile/add_address_screen.dart';
import '/screens/auth/user_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'constants/constants.dart';
import 'model/brand_model.dart';
import 'model/cart_provider.dart';
import 'model/category_model.dart';
import 'model/orders.dart';
import 'screens/auth/login_view.dart';
import 'screens/auth/signup_view.dart';
import 'screens/home/brands_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/home/home_page_screen.dart';
import 'screens/home/details_screen.dart';
import 'screens/tap_screen.dart';
import 'screens/home/products_screen.dart';
import '../screens/auth/user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _appInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _appInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text(
                  'App is loading',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text(
                  ' error',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }
        return  MultiProvider(
            providers: [
              
              ChangeNotifierProvider(
                create: (_) => Cart(),
              ),
             
              ChangeNotifierProvider(
                create: (_) => Orders(),
              ),
              ChangeNotifierProvider(
                create: (_) => DUMMYCATEGORIES(),
              ),
              ChangeNotifierProvider(
                create: (_) => DUMMYBRANDS(),
              ),
            ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-Commerce-App',
            theme: ThemeData(
              //=======================
              fontFamily: 'Lato',
              //=======================
        
              primaryColor: kPrimaryColor,
              accentColor: kPrimaryColor,
              //=======================
              textTheme: TextTheme(
                headline1: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                headline2: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Anton'),
                headline3: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF023047),
                  fontSize: 27,
                 
                ),
                headline4: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //=======================
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Color(0xfff2f9fe),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            home: UserState(),
            routes: {
              'signup': (ctx) => SignUpView(),
              'login': (ctx) => LogInView(),
              'homepage': (ctx) => HomePageScreen(),
              'profile': (ctx) => ProfileScreen(),
              CartScreen.routeName:(ctx)=>CartScreen(),
              'topview': (ctx) => TapScreen(),
              'addaddress': (ctx) => AddAddressScreen(),
              'EditProfile': (ctx) => EditProfileScreen(),
              
              BrandsScreen.id:(ctx)=>BrandsScreen(),
              ProductsScreen.id: (ctx) => ProductsScreen(),
              DetailsScreen.ronteName: (ctx) => DetailsScreen(),
            },
          ),
        );
      },
    );
  }
}
