import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/keranjang_data.dart';
import 'package:flutter_application_2/data/keranjang.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _tambahQuantity(Keranjang item) {
    setState(() {
      item.quantity++;
    });
  }

  void _kurangiQuantity(Keranjang item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),
      body: globalCart.isEmpty
          ? const Center(child: Text("Keranjang kosong"))
          : ListView.builder(
              itemCount: globalCart.length,
              itemBuilder: (context, index) {
                final item = globalCart[index];
                return ListTile(
                  leading: item.icon != null
                      ? Icon(item.icon, size: 32, color: Colors.deepOrange)
                      : (item.gambar != null
                          ? Image.asset(item.gambar!, width: 40, height: 40)
                          : const Icon(Icons.shopping_bag)),
                  title: Text(item.nama),
                  subtitle: Text("Rp ${item.harga}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _kurangiQuantity(item),
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _tambahQuantity(item),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
