import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/layanan_data.dart';
import 'package:flutter_application_2/data/layanan.dart';
import 'package:flutter_application_2/data/cart_data.dart';

class LayananScreen extends StatefulWidget {
  const LayananScreen({super.key});

  @override
  State<LayananScreen> createState() => _LayananScreenState();
}

class _LayananScreenState extends State<LayananScreen> {
  void addToCart(Layanan layanan) {
    // Cek apakah layanan sudah ada di keranjang global
    final existingItem = globalCart.firstWhere(
      (item) => item.nama == layanan.nama,
      orElse: () =>
          Keranjang(nama: "", harga: 0, icon: Icons.miscellaneous_services),
    );

    if (existingItem.nama.isNotEmpty) {
      existingItem.jumlah++;
    } else {
      globalCart.add(
        Keranjang(
          nama: layanan.nama,
          harga: layanan.harga.toInt(), // konversi double ke int
          icon: Icons.miscellaneous_services,
          gambar: layanan.gambar,
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${layanan.nama} ditambahkan ke keranjang"),
        duration: const Duration(seconds: 1),
      ),
    );

    setState(() {}); // refresh ikon keranjang
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Layanan"),
        backgroundColor: const Color.fromARGB(255, 131, 201, 237),
        actions: [
          // 🔹 Ikon keranjang (digeser sedikit ke kiri)
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
                    ).then(
                      (_) => setState(() {}),
                    ); // update badge setelah kembali
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
        itemCount: layananList.length,
        itemBuilder: (context, index) {
          final layanan = layananList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  layanan.gambar,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                layanan.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(layanan.deskripsi),
                  const SizedBox(height: 4),
                  Text(
                    "Rp ${layanan.harga.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () => addToCart(layanan),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 118, 195, 243),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Pesan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GlobalCartScreen extends StatefulWidget {
  const GlobalCartScreen({super.key});

  @override
  State<GlobalCartScreen> createState() => _GlobalCartScreenState();
}

class _GlobalCartScreenState extends State<GlobalCartScreen> {
  void removeFromCart(int index) {
    setState(() {
      globalCart.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        backgroundColor: const Color.fromARGB(255, 131, 201, 237),
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
                    children: [
                      if (item.gambar != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.gambar!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
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
                            Text("Jumlah: ${item.jumlah}"),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeFromCart(index),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
