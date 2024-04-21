import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warung_bu_ode/models/menu.dart';

class Invoice {
  final String id;
  final DateTime date;
  final List<MenuItem> items;

  Invoice({required this.id, required this.date, required this.items});

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'items': items.map((item) => item.toJson()).toList(),
      };

  static Invoice fromJson(Map<String, dynamic> json) => Invoice(
        id: json['id'],
        date: DateTime.parse(json['date']),
        items: (json['items'] as List)
            .map((item) => MenuItem.fromJson(item))
            .toList(),
      );

  double get total {
    return items.fold(0, (total, item) => total + (item.price * item.quantity));
  }
}

// Define the InvoiceProvider class
class InvoiceProvider with ChangeNotifier {
  List<Invoice> _invoices = [];

  List<Invoice> get invoices => _invoices;

  void addInvoice(Invoice invoice) {
    _invoices.add(invoice);
    saveInvoicesToPrefs();
    notifyListeners();
  }

  Future<void> saveInvoicesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final invoicesData = _invoices.map((invoice) => invoice.toJson()).toList();
    await prefs.setString('invoices', json.encode(invoicesData));
  }

  Future<void> loadInvoicesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final invoicesData = prefs.getString('invoices');
    if (invoicesData != null) {
      final invoicesList = json.decode(invoicesData) as List;
      _invoices =
          invoicesList.map((invoice) => Invoice.fromJson(invoice)).toList();
      notifyListeners();
    }
  }
}
