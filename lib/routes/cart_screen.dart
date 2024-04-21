import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warung_bu_ode/models/cart.dart';
import 'package:intl/intl.dart';
import 'package:warung_bu_ode/models/invoice.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final idrFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return ListTile(
                title: Text(item.title),
                subtitle: Text(idrFormat.format(item.price)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        cart.removeItem(item);
                      },
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cart.addItem(item);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final invoice = Invoice(
                    id: DateTime.now().toString(),
                    date: DateTime.now(),
                    items: List.from(cart.items),
                  );
                  return AlertDialog(
                    title: Text('Invoice'),
                    content: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Add this line
                      children: [
                        Divider(
                          color: Colors.grey,
                          height: 30,
                          thickness: 1,
                        ),
                        Text(
                          'ID: ${invoice.id}',
                          textAlign: TextAlign.start,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 30,
                          thickness: 1,
                        ),
                        Text(
                            'Date: ${DateFormat('yyyy-MM-dd').format(invoice.date)}'),
                        ...invoice.items.map((item) => Text(
                            '${item.title}: ${item.quantity} x ${idrFormat.format(item.price)} = ${idrFormat.format(item.price * item.quantity)}')),
                        Divider(
                          color: Colors.grey,
                          height: 30,
                          thickness: 1,
                        ),
                        Text('Total: ${idrFormat.format(invoice.total)}'),
                        Divider(
                          color: Colors.grey,
                          height: 30,
                          thickness: 1,
                        ),
                        Text('Note:'),
                        Text('1. Screenshot this invoice.'),
                        Text('2. Bring the screenshot to the cashier.'),
                        Text('3. Pay according to the invoice.'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          'Sudah Saya SS',
                          style: TextStyle(color: Colors.green),
                        ),
                        onPressed: () {
                          cart.clearCart();
                          Navigator.pop(context, 'OK');
                        },
                      ),
                    ],
                  );
                },
              );
            },
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            shape: null,
            label: Text('Total: ${idrFormat.format(cart.totalPrice)}'),
            icon: Icon(Icons.payment),
          );
        },
      ),
    );
  }
}
