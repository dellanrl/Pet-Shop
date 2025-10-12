import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'model/aksesoris_screen.dart';
import 'model/food_screen.dart';
import 'model/profile_screen.dart';
import 'model/produk_screen.dart';
import 'model/layanan_screen.dart';
import 'model/keranjang_screen.dart';
import 'data/cart_data.dart'; 

class HomeScreen extends StatefulWidget {
  final String email;

  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "title": "Makanan",
        "icon": Icons.fastfood,
        "gradient": [Colors.orange.shade300, Colors.deepOrange.shade200],
      },
      {
        "title": "Aksesoris & Peralatan",
        "icon": Icons.shopping_bag,
        "gradient": [Colors.green.shade300, Colors.teal.shade200],
      },
      {
        "title": "Produk Perawatan",
        "icon": Icons.spa,
        "gradient": [Colors.purple.shade300, Colors.pink.shade200],
      },
      {
        "title": "Layanan",
        "icon": Icons.pets,
        "gradient": [Colors.cyan.shade300, Colors.blue.shade200],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pet Shop',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Welcome, ${widget.email} 👋",
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: Colors.black87,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const KeranjangScreen(),
                                ),
                              );
                              setState(() {}); 
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: MasonryGridView.count(
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        if (item["title"] == "Makanan") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FoodScreen(),
                            ),
                          );
                        } else if (item["title"] == "Aksesoris & Peralatan") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AksesorisScreen(),
                            ),
                          );
                        } else if (item["title"] == "Produk Perawatan") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProdukPerawatanScreen(),
                            ),
                          );
                        } else if (item["title"] == "Layanan") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LayananScreen(),
                            ),
                          );
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: item["gradient"],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(3, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Icon(
                                  item["icon"],
                                  size: 42,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                item["title"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.grey[300],
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              child: const Icon(Icons.logout, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
