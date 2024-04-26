import 'package:flutter/material.dart';
import 'package:warung_bu_ode/models/menu.dart';
import 'package:intl/intl.dart';
import 'package:warung_bu_ode/routes/detail_screen.dart';

class ViewAllMenuScreen extends StatefulWidget {
  const ViewAllMenuScreen({Key? key}) : super(key: key); 

  static const routeName = '/ViewAllMenuScreen';

  @override
  _ViewAllMenuScreenState createState() => _ViewAllMenuScreenState();
}

class _ViewAllMenuScreenState extends State<ViewAllMenuScreen> { 
  final idrFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Semua Makanan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Makanan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...MenuWarung.makanan.map(
                (menuItem) {
                  return ListTile(
                    leading: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          menuItem.image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(menuItem.title),
                    subtitle: Text(idrFormat.format(menuItem.price)),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailScreen.routeName,
                        arguments: menuItem,
                      );
                    },
                  );
                },
              ).toList(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Minuman',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...MenuWarung.minuman.map(
                (menuItem) {
                  return ListTile(
                    leading: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          menuItem.image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(menuItem.title),
                    subtitle: Text(idrFormat.format(menuItem.price)),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailScreen.routeName,
                        arguments: menuItem,
                      );
                    },
                  );
                },
              ).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
