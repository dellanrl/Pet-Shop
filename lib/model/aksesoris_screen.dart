import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/cart_data.dart'; // ✅ tambah import globalCart

class Aksesoris {
  final String nama;
  final String harga;
  final IconData icon;

  Aksesoris({required this.nama, required this.harga, required this.icon});
}

class AksesorisScreen extends StatefulWidget {
  const AksesorisScreen({super.key});

  @override
  State<AksesorisScreen> createState() => _AksesorisScreenState();
}

class _AksesorisScreenState extends State<AksesorisScreen> {
  final List<Aksesoris> aksesoris = [
    Aksesoris(nama: "Kalung Hewan", harga: "Rp 25.000", icon: Icons.pets),
    Aksesoris(nama: "Kandang Mini", harga: "Rp 350.000", icon: Icons.home),
    Aksesoris(
      nama: "Mainan Bola",
      harga: "Rp 15.000",
      icon: Icons.sports_baseball,
    ),
    Aksesoris(nama: "Tempat Makan", harga: "Rp 40.000", icon: Icons.fastfood),
    Aksesoris(nama: "Grooming Kit", harga: "Rp 120.000", icon: Icons.cut),
  ];

  final List<Aksesoris> cart = [];

  void addToCart(Aksesoris item) {
    setState(() {
      cart.add(item);
    });

    // ✅ Tambahkan juga ke keranjang global
    globalCart.add(
      Keranjang(nama: item.nama, harga: item.harga, icon: item.icon),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${item.nama} ditambahkan ke keranjang"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aksesoris & Peralatan"),
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cart: cart),
                    ),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: aksesoris.length,
        itemBuilder: (context, index) {
          final item = aksesoris[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(item.icon, size: 40, color: Colors.teal),
              title: Text(
                item.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.harga),
              trailing: ElevatedButton(
                onPressed: () => addToCart(item),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Beli"),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Aksesoris> cart;

  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),
      body: cart.isEmpty
          ? const Center(child: Text("Keranjang kosong"))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(item.icon, size: 28, color: Colors.teal),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            item.harga,
                            style: const TextStyle(
                              color: Color.fromARGB(136, 5, 5, 5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
