import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/cart_data.dart';

class KeranjangScreen extends StatefulWidget {
  const KeranjangScreen({super.key});

  @override
  State<KeranjangScreen> createState() => _KeranjangScreenState();
}

class _KeranjangScreenState extends State<KeranjangScreen> {
  void _hapusItem(int index) {
    setState(() {
      globalCart.removeAt(index);
    });
  }

  void _tambahQuantity(Keranjang item) {
    setState(() {
      item.jumlah++;
    });
  }

  void _kurangiQuantity(Keranjang item) {
    setState(() {
      if (item.jumlah > 1) {
        item.jumlah--;
      }
    });
  }

  int _hitungTotal() {
    int total = 0;
    for (var item in globalCart) {
      total += item.harga * item.jumlah;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Belanja")),
      body: Column(
        children: [
          Expanded(
            child: globalCart.isEmpty
                ? const Center(child: Text("Keranjang kosong"))
                : ListView.builder(
                    itemCount: globalCart.length,
                    itemBuilder: (context, index) {
                      final Keranjang item = globalCart[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: item.icon != null
                              ? Icon(item.icon, color: Colors.deepOrange)
                              : (item.gambar != null
                                    ? Image.asset(
                                        item.gambar!,
                                        width: 40,
                                        height: 40,
                                      )
                                    : const Icon(Icons.shopping_bag)),
                          title: Text(
                            item.nama,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rp${item.harga}"),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _kurangiQuantity(item),
                                  ),
                                  Text(
                                    "${item.jumlah}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: Colors.green,
                                    ),
                                    onPressed: () => _tambahQuantity(item),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _hapusItem(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (globalCart.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "Total: Rp${_hitungTotal()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[300],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (globalCart.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Keranjang masih kosong"),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckoutScreen(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
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

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  int _totalCheckout() {
    int total = 0;
    for (var item in globalCart) {
      total += item.harga * item.jumlah;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: globalCart.isEmpty
          ? const Center(child: Text("Tidak ada item untuk checkout"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: globalCart.length,
              itemBuilder: (context, index) {
                final Keranjang item = globalCart[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: item.icon != null
                        ? Icon(item.icon, color: Colors.deepOrange)
                        : (item.gambar != null
                              ? Image.asset(item.gambar!, width: 40, height: 40)
                              : const Icon(Icons.shopping_bag)),
                    title: Text(item.nama),
                    subtitle: Text("Rp${item.harga} x${item.jumlah}"),
                  ),
                );
              },
            ),
      bottomNavigationBar: globalCart.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total Pembayaran: Rp${_totalCheckout()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Checkout berhasil!")),
                      );
                      globalCart.clear();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Konfirmasi Pembayaran",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
