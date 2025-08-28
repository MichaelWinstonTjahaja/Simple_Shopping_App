import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final Map<int, Map<String, dynamic>> cart;
  final Function(int) removeItemFromCart;
  final Future<void> Function()? onNavigateBack;

  const CartPage({
    Key? key,
    required this.cart,
    required this.removeItemFromCart,
    this.onNavigateBack,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double _calculateTotal() {
    double total = 0;
    widget.cart.forEach((key, value) {
      total += value['price'] * value['quantity'];
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            if (widget.onNavigateBack != null) {
              await widget.onNavigateBack!();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: widget.cart.entries.map((entry) {
                final item = entry.value;
                final itemId = entry.key;
                return _buildCartItem(itemId, item);
              }).toList(),
            ),
          ),
          _buildCartTotal(),
        ],
      ),
    );
  }

  Widget _buildCartItem(int itemId, Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
              child: const Icon(Icons.image, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Rp${item['price'].toStringAsFixed(0)} x ${item['quantity']}'),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                widget.removeItemFromCart(itemId);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartTotal() {
    final total = _calculateTotal();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Rp${total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: total == 0
                ? null
                : () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirm Checkout'),
                          content: Text('Are you sure you want to checkout?\nTotal: Rp${total.toStringAsFixed(0)}'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirmed == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Checking out... (Dummy)')),
                      );
                    }
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}