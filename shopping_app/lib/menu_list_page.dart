import 'package:flutter/material.dart';

class MenuListPage extends StatefulWidget {
  final List<Map<String, dynamic>> menuItems;
  final Map<int, Map<String, dynamic>> cart;
  final Function(int, int) updateQuantity;
  final Function(int) removeItemFromCart;
  final VoidCallback? onNavigateToCart;

  const MenuListPage({
    Key? key,
    required this.menuItems,
    required this.cart,
    required this.updateQuantity,
    required this.removeItemFromCart,
    this.onNavigateToCart,
  }) : super(key: key);

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.menuItems.length,
              itemBuilder: (context, index) {
                final item = widget.menuItems[index];
                return _buildMenuItem(item);
              },
            ),
          ),
          _buildViewCartButton(context),
        ],
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
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
                  Text('Rp${item['price'].toStringAsFixed(0)}'),
                ],
              ),
            ),
            _buildQuantityControls(item),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControls(Map<String, dynamic> item) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (item['quantity'] > 0) {
              widget.updateQuantity(item['id'], item['quantity'] - 1);
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Text(
          item['quantity'].toString(),
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          onPressed: () {
            widget.updateQuantity(item['id'], item['quantity'] + 1);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildViewCartButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onNavigateToCart ?? () {
          Navigator.pushNamed(context, '/cart');
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('View Cart'),
      ),
    );
  }
}