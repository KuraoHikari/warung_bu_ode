import 'package:flutter/material.dart';
import 'package:warung_bu_ode/models/cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:warung_bu_ode/routes/cart_screen.dart';
import 'package:warung_bu_ode/routes/detail_screen.dart';
import 'package:warung_bu_ode/routes/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:warung_bu_ode/routes/view_all_menu_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  ); // Running the Flutter application.
}

// MyApp widget is the root of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      routes: {
        DetailScreen.routeName: (context) => const DetailScreen(),
        CartScreen.routeName: (context) => const CartScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ViewAllMenuScreen.routeName: (context) => const ViewAllMenuScreen(),
      },
      title: 'Warung BU ODE', // Setting the title of the application.
      home: const HomeScreen(), // Setting the home page of the application.
    );
  }
}
