
import 'package:flutter/material.dart';
import 'menu_list_page.dart';
import 'cart_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> menuItems = [
    {'id': 1, 'name': 'Nasi Goreng', 'price': 20000, 'quantity': 0},
    {'id': 2, 'name': 'Bakso', 'price': 15000, 'quantity': 0},
    {'id': 3, 'name': 'Es Teh', 'price': 5000, 'quantity': 0},
  ];

  final Map<int, Map<String, dynamic>> cart = {};

  void _updateQuantity(int itemId, int newQuantity) {
    setState(() {
      final itemIndex = menuItems.indexWhere((item) => item['id'] == itemId);
      if (itemIndex != -1) {
        menuItems[itemIndex]['quantity'] = newQuantity;
        if (newQuantity > 0) {
          cart[itemId] = {
            'name': menuItems[itemIndex]['name'],
            'price': menuItems[itemIndex]['price'],
            'quantity': newQuantity,
          };
        } else {
          cart.remove(itemId);
        }
      }
    });
  }

  void _removeItemFromCart(int itemId) {
    setState(() {
      cart.remove(itemId);
      final itemIndex = menuItems.indexWhere((item) => item['id'] == itemId);
      if (itemIndex != -1) {
        menuItems[itemIndex]['quantity'] = 0;
      }
    });
  }

  // Show loading dialog
  Future<void> _showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Custom navigator with loading
  Future<void> _navigateWithLoading(BuildContext context, String routeName) async {
    await _showLoadingDialog(context);
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Builder(
        builder: (context) => MenuListPage(
          menuItems: menuItems,
          cart: cart,
          updateQuantity: _updateQuantity,
          removeItemFromCart: _removeItemFromCart,
          onNavigateToCart: () => _navigateWithLoading(context, '/cart'),
        ),
      ),
      routes: {
        '/cart': (context) => Builder(
              builder: (context) => CartPage(
                cart: cart,
                removeItemFromCart: _removeItemFromCart,
                onNavigateBack: () async {
                  await _showLoadingDialog(context);
                  Navigator.of(context).pop();
                },
              ),
            ),
      },
    );
  }
}