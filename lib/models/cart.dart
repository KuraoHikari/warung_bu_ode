import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warung_bu_ode/models/menu.dart';

class CartProvider with ChangeNotifier {
  List<MenuItem> _items = [];

  List<MenuItem> get items => _items;

  double get totalPrice {
    return _items.fold(
        0, (total, current) => total + (current.price * current.quantity));
  }

  void addItem(MenuItem item) {
    var foundItem = _items.firstWhere((i) => i.id == item.id,
        orElse: () =>
            MenuItem(id: -1, title: '', price: 0.0, desc: '', image: ''));
    if (foundItem.id != -1) {
      foundItem.quantity += 1;
    } else {
      _items.add(item);
    }
    saveItemsToPrefs();
    notifyListeners();
  }

  void removeItem(MenuItem item) {
    print(item.quantity);
    item.quantity -= 1;
    if (item.quantity <= 0) {
      _items.remove(item);
    }
    print(item.quantity);
    saveItemsToPrefs();
    notifyListeners();
  }

  Future<void> saveItemsToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      _items.map((item) => item.toJson()).toList(),
    );
    await prefs.setString('cartItems', encodedData);
  }

  Future<void> loadItemsFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? itemsString = prefs.getString('cartItems');
    if (itemsString != null) {
      final List<dynamic> jsonData = json.decode(itemsString) as List<dynamic>;
      _items = jsonData
          .map((item) => MenuItem.fromJson(item as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  // Call this method to clear all items in cart
  Future<void> clearCart() async {
    _items = [];
    await saveItemsToPrefs();
    notifyListeners();
  }
}
