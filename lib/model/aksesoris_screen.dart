import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/cart_data.dart';

class Aksesoris {
  final String nama;
  final int harga;
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
    Aksesoris(nama: "Kalung Hewan", harga: 25000, icon: Icons.pets),
    Aksesoris(nama: "Kandang Mini", harga: 350000, icon: Icons.home),
    Aksesoris(nama: "Mainan Bola", harga: 15000, icon: Icons.sports_baseball),
    Aksesoris(nama: "Tempat Makan", harga: 40000, icon: Icons.fastfood),
    Aksesoris(nama: "Grooming Kit", harga: 120000, icon: Icons.cut),
  ];

  void addToCart(Aksesoris item) {
    final existing = globalCart.firstWhere(
      (produk) => produk.nama == item.nama,
      orElse: () => Keranjang(nama: '', harga: 0),
    );

    if (existing.nama.isNotEmpty) {
      existing.jumlah++;
    } else {
      globalCart.add(
        Keranjang(nama: item.nama, harga: item.harga, icon: item.icon),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${item.nama} ditambahkan ke keranjang"),
        duration: const Duration(seconds: 1),
      ),
    );

    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aksesoris & Peralatan"),
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
        actions: [
          
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GlobalCartScreen(),
                      ),
                    );
                  },
                ),
                if (globalCart.isNotEmpty)
                  Positioned(
                    right: 6, 
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        globalCart.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
              subtitle: Text("Rp ${item.harga}"),
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

class GlobalCartScreen extends StatelessWidget {
  const GlobalCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int totalHarga = 0;
    for (var item in globalCart) {
      totalHarga += item.harga * item.jumlah;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
      ),
      body: globalCart.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: globalCart.length,
                    itemBuilder: (context, index) {
                      final item = globalCart[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                                      "Rp ${item.harga}",
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "x${item.jumlah}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp $totalHarga",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
