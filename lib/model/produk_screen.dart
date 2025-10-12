import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/cart_data.dart';

class ProdukPerawatan {
  final String nama;
  final int harga; 
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
    ProdukPerawatan(nama: "Shampoo Hewan", harga: 45000, icon: Icons.spa),
    ProdukPerawatan(
      nama: "Vitamin Anjing",
      harga: 60000,
      icon: Icons.medication,
    ),
    ProdukPerawatan(
      nama: "Vitamin Kucing",
      harga: 55000,
      icon: Icons.local_hospital,
    ),
    ProdukPerawatan(nama: "Sisir Grooming", harga: 30000, icon: Icons.cut),
    ProdukPerawatan(nama: "Obat Kutu", harga: 75000, icon: Icons.healing),
  ];

  void addToCart(ProdukPerawatan produk) {
    final existing = globalCart.firstWhere(
      (item) => item.nama == produk.nama,
      orElse: () => Keranjang(nama: '', harga: 0),
    );

    if (existing.nama.isNotEmpty) {
      existing.jumlah++; 
    } else {
      globalCart.add(
        Keranjang(nama: produk.nama, harga: produk.harga, icon: produk.icon),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${produk.nama} ditambahkan ke keranjang")),
    );

    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Perawatan"),
        backgroundColor: const Color.fromARGB(255, 227, 130, 242),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
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
                    ).then((_) => setState(() {})); 
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
              leading: Icon(item.icon, size: 40, color: Colors.purple),
              title: Text(
                item.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Rp ${item.harga}",
              ), 
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

class GlobalCartScreen extends StatelessWidget {
  const GlobalCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        backgroundColor: const Color.fromARGB(255, 227, 130, 242),
      ),
      body: globalCart.isEmpty
          ? const Center(
              child: Text(
                "Keranjang masih kosong",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: globalCart.length,
              itemBuilder: (context, index) {
                final item = globalCart[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(item.icon, size: 32, color: Colors.purple),
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
