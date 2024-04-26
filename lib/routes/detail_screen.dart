import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warung_bu_ode/models/cart.dart';
import 'package:warung_bu_ode/models/menu.dart';
import 'package:intl/intl.dart';
import 'package:warung_bu_ode/routes/home_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  static const routeName = '/detailScreen';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final idrFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MenuItem;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  Provider.of<CartProvider>(context, listen: false)
                      .addItem(args);
                  _showToast(context);
                  await Future.delayed(Duration(seconds: 3));
                  Navigator.pushNamed(
                    context,
                    HomeScreen.routeName,
                  );
                  setState(() {
                    _isLoading = false;
                  });
                },
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          shape: null,
          label: _isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0, // adjust the size as needed
                      width: 20.0, // adjust the size as needed
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Loading...',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              : const Text('Add to cart'),
          icon: const Icon(Icons.add_shopping_cart),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                        child: Container(
                          height: 310,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              //image size fill
                              image: AssetImage('assets/images/wp.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, top: 20),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                            ),
                            iconSize: 20,
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 280,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              //image size fill
                              image: AssetImage(args.image),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 300),
                    //   child: Center(
                    //       child: InputChip(
                    //     color: MaterialStateProperty.all<Color>(Colors.blue),
                    //     label: Text(args.type),
                    //   )),
                    // )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Card(
                    color: Colors.green,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 0, top: 15, left: 20, right: 20),
                          child: Row(
                            children: [
                              Text(
                                args.title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Inter",
                                    color: Colors.white),
                              ),
                              const Spacer(),
                              Text(
                                idrFormat.format(args.price),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Inter",
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              bottom: 0, top: 15, left: 20, right: 20),
                          child: Row(
                            children: [
                              Text(
                                "Deskripsi :",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Inter",
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, top: 0, left: 20, right: 20),
                          child: Text(
                            args.desc,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "Inter",
                                color: Colors.white),
                          ),
                        ),
                      ],
                    )),
              ),

              // or any other specific height
            ],
          ),
        ));
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final args = ModalRoute.of(context)!.settings.arguments as MenuItem;
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Adding ${args.title} to cart',
          style: const TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).removeItem(args);
            scaffold.hideCurrentSnackBar;
          },
        ),
      ),
    );

    // Future.delayed(Duration(seconds: 3)).then((_) {
    //   scaffold.hideCurrentSnackBar();
    // });
  }
}
