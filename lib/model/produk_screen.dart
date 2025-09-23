import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/cart_data.dart'; // ✅ pakai globalCart

class ProdukPerawatan {
  final String nama;
  final String harga;
  final IconData icon;

  ProdukPerawatan({
    required this.nama,
    required this.harga,
    required this.icon,
  });
}

class ProdukPerawatanScreen extends StatefulWidget {
  const ProdukPerawatanScreen({super.key});

  @override
  State<ProdukPerawatanScreen> createState() => _ProdukPerawatanScreenState();
}

class _ProdukPerawatanScreenState extends State<ProdukPerawatanScreen> {
  final List<ProdukPerawatan> perawatanList = [
    ProdukPerawatan(nama: "Shampoo Hewan", harga: "Rp 45.000", icon: Icons.spa),
    ProdukPerawatan(
      nama: "Vitamin Anjing",
      harga: "Rp 60.000",
      icon: Icons.medication,
    ),
    ProdukPerawatan(
      nama: "Vitamin Kucing",
      harga: "Rp 55.000",
      icon: Icons.local_hospital,
    ),
    ProdukPerawatan(
      nama: "Sisir Grooming",
      harga: "Rp 30.000",
      icon: Icons.cut,
    ),
    ProdukPerawatan(nama: "Obat Kutu", harga: "Rp 75.000", icon: Icons.healing),
  ];

  final List<ProdukPerawatan> cart = []; // keranjang lokal

  void addToCart(ProdukPerawatan produk) {
    setState(() {
      cart.add(produk);
    });

    // ✅ juga masuk ke keranjang global
    globalCart.add(
      Keranjang(nama: produk.nama, harga: produk.harga, icon: produk.icon),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${produk.nama} ditambahkan ke keranjang"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Perawatan"),
        backgroundColor: const Color.fromARGB(255, 227, 130, 242),
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
        itemCount: perawatanList.length,
        itemBuilder: (context, index) {
          final item = perawatanList[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(
                item.icon,
                size: 40,
                color: const Color.fromARGB(255, 220, 92, 243),
              ),
              title: Text(
                item.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item.harga),
              trailing: ElevatedButton(
                onPressed: () => addToCart(item),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 225, 129, 242),
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
  final List<ProdukPerawatan> cart;

  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Perawatan")),
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
                    color: Colors.purple[100],
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
                      Icon(item.icon, size: 28, color: Colors.purple),
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
