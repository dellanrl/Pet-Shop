import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/food.dart';
import 'package:flutter_application_2/data/food_data.dart';
import 'package:flutter_application_2/data/cart_data.dart';
import 'package:flutter_application_2/model/keranjang_screen.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<Food> filterByCategory(Category category) {
    return foods.where((food) => food.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Makanan Hewan"),
        backgroundColor: const Color.fromARGB(255, 240, 188, 138),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildCategoryBox(
              context,
              "Cat",
              Icons.pets,
              Colors.pink[100]!,
              Category.Kucing,
            ),
            buildCategoryBox(
              context,
              "Dog",
              Icons.pets,
              Colors.blue[100]!,
              Category.Anjing,
            ),
            buildCategoryBox(
              context,
              "Bird",
              Icons.pets,
              Colors.green[100]!,
              Category.Burung,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryBox(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Category category,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodListScreen(
              title: title,
              foodsInCategory: filterByCategory(category),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.black54),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class FoodListScreen extends StatefulWidget {
  final String title;
  final List<Food> foodsInCategory;

  const FoodListScreen({
    super.key,
    required this.title,
    required this.foodsInCategory,
  });

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  void addToCart(Food food) {
    final existing = globalCart.firstWhere(
      (item) => item.nama == food.name,
      orElse: () => Keranjang(nama: '', harga: 0),
    );

    if (existing.nama.isNotEmpty) {
      existing.jumlah++;
    } else {
      globalCart.add(
        Keranjang(
          nama: food.name,
          harga:
              int.tryParse(food.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
          icon: food.icon,
        ),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${food.name} ditambahkan ke keranjang 🛒"),
        duration: const Duration(seconds: 1),
      ),
    );
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                        builder: (context) => const KeranjangScreen(),
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
        itemCount: widget.foodsInCategory.length,
        itemBuilder: (context, index) {
          final food = widget.foodsInCategory[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange[100],
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
                    Icon(food.icon, size: 32, color: Colors.deepOrange),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          food.price,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => addToCart(food),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 233, 217, 212),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Beli"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
