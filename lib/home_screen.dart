import 'package:flutter/material.dart';
import 'login.dart';
import 'model/aksesoris_screen.dart';
import 'model/food_screen.dart';
import 'model/profile_screen.dart';
import 'model/produk_screen.dart';
import 'model/layanan_screen.dart';
import 'model/keranjang_screen.dart';

class HomeScreen extends StatelessWidget {
  final String email;

  const HomeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {"title": "Profile", "icon": Icons.person, "color": Colors.blue[100]},
      {"title": "Makanan", "icon": Icons.fastfood, "color": Colors.orange[100]},
      {
        "title": "Aksesoris & Peralatan",
        "icon": Icons.shopping_bag,
        "color": Colors.green[100],
      },
      {
        "title": "Produk Perawatan",
        "icon": Icons.spa,
        "color": Colors.purple[100],
      },
      {"title": "Layanan", "icon": Icons.pets, "color": Colors.teal[100]},
      {
        "title": "Keranjang Belanja",
        "icon": Icons.shopping_cart,
        "color": Colors.yellow[100],
      },
      {"title": "Logout", "icon": Icons.logout, "color": Colors.grey[300]},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Welcome, $email 👋",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    if (item["title"] == "Profile") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    } else if (item["title"] == "Makanan") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodScreen(),
                        ),
                      );
                    } else if (item["title"] == "Aksesoris & Peralatan") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AksesorisScreen(),
                        ),
                      );
                    } else if (item["title"] == "Produk Perawatan") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProdukPerawatanScreen(),
                        ),
                      );
                    } else if (item["title"] == "Layanan") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LayananScreen(),
                        ),
                      );
                    } else if (item["title"] == "Keranjang Belanja") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KeranjangScreen(),
                        ),
                      );
                    } else if (item["title"] == "Logout") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    }
                  },
                  child: Card(
                    color: item["color"],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item["icon"], size: 40, color: Colors.black54),
                        const SizedBox(height: 10),
                        Text(
                          item["title"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
