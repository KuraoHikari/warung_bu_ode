import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warung_bu_ode/models/cart.dart';
import 'package:intl/intl.dart';
import 'package:warung_bu_ode/models/invoice.dart';
import 'package:warung_bu_ode/routes/home_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = '/cartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final idrFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  void launchURL(String link) async {
    final Uri url = Uri.parse(
        'https://wa.me/6283114227556?text=${Uri.encodeComponent(link)}');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
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
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        cart.removeItem(item);
                      },
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add),
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
                    title: const Text('Invoice'),
                    content: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Add this line
                      children: [
                        const Divider(
                          color: Colors.grey,
                          height: 30,
                          thickness: 1,
                        ),
                        Text(
                          'ID: ${invoice.id}',
                          textAlign: TextAlign.start,
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 30,
                          thickness: 1,
                        ),
                        Text(
                            'Date: ${DateFormat('yyyy-MM-dd').format(invoice.date)}'),
                        ...invoice.items.map((item) => Text(
                            '${item.title}: ${item.quantity} x ${idrFormat.format(item.price)} = ${idrFormat.format(item.price * item.quantity)}')),
                        const Divider(
                          color: Colors.grey,
                          height: 30,
                          thickness: 1,
                        ),
                        Text('Total: ${idrFormat.format(invoice.total)}'),
                        const Divider(
                          color: Colors.grey,
                          height: 30,
                          thickness: 1,
                        ),
                        const Text('Note:'),
                        const Text(
                            '1. Kirim pesan invoice ke whatsapp kasir dengan menekan tombol kirim pesan.'),
                        const Text('2. Bawa pesan invoice ke kasir.'),
                        const Text('3. Bayar sesuai invoice.'),
                        const Text(
                            '4. Ambil nomor meja yang diberikan oleh kasir.'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          'Kirim Pesan Whatssapp',
                          style: TextStyle(color: Colors.green),
                        ),
                        onPressed: () {
                          String message = '*Invoice*\n'
                              '============================\n'
                              'ID: ${invoice.id}\n'
                              'Date: ${DateFormat('yyyy-MM-dd').format(invoice.date)}\n'
                              '=========== *MENU* =========\n'
                              '${invoice.items.map((item) => '*${item.title}*: ${item.quantity} x ${idrFormat.format(item.price)} = ${idrFormat.format(item.price * item.quantity)}').join('\n')}\n'
                              '============================\n'
                              '*Total*: ${idrFormat.format(invoice.total)}\n'
                              '============================\n'
                              '*Note*:\n'
                              '1. Kirim pesan invoice ke whatsapp kasir dengan menekan tombol kirim pesan.\n'
                              '2. Bawa pesan invoice ke kasir.\n'
                              '3. Bayar sesuai invoice.\n'
                              '4. Ambil nomor meja yang diberikan oleh kasir.';
                          launchURL(message);
                          cart.clearCart();
                          Navigator.pop(context, 'OK');
                          Navigator.pushNamed(
                            context,
                            HomeScreen.routeName,
                          );
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
            icon: const Icon(Icons.payment),
          );
        },
      ),
    );
  }
}
