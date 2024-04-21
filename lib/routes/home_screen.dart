import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warung_bu_ode/components/scroll_views/horizontal_scroll_view.dart';
import 'package:warung_bu_ode/models/cart.dart';

import 'package:warung_bu_ode/routes/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.loadItemsFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(
              context,
              CartScreen.routeName,
            );
          },
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          shape: null,
          label: const Text('Cart'),
          icon: const Icon(Icons.shopping_cart),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.only(
                // top: MediaQuery.of(context).padding.top + 60,
                bottom: MediaQuery.of(context).padding.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          child: Image.asset(
                            'assets/images/wp.png',
                            height: 300,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Makanan",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        "Lihat Semua",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Inter",
                            color: Colors.green),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.green,
                        size: 16.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ],
                  ),
                ),
                const HorizontalScrollView(
                  product: "makanan",
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Minuman",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Spacer(),
                      Text(
                        "Lihat Semua",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Inter",
                            color: Colors.green),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.green,
                        size: 16.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ],
                  ),
                ),
                const HorizontalScrollView(
                  product: "minuman",
                ),
              ],
            )));
  }
}
