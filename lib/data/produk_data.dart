import 'package:flutter/material.dart';

class Produk {
  String _nama;
  int _harga; // tipe int biar bisa dipakai untuk perhitungan
  IconData _icon;
  String _kategori;

  Produk({
    required String nama,
    required int harga, // ubah ke int
    required IconData icon,
    required String kategori,
  }) : _nama = nama,
       _harga = harga,
       _icon = icon,
       _kategori = kategori;

  // === Getter ===
  String get nama => _nama;
  int get harga => _harga;
  IconData get icon => _icon;
  String get kategori => _kategori;

  // === Setter ===
  set nama(String value) => _nama = value;
  set harga(int value) => _harga = value;
  set icon(IconData value) => _icon = value;
  set kategori(String value) => _kategori = value;
}

// =======================
// PRODUK MAKANAN
// =======================
List<Produk> produkMakanan = [
  Produk(
    nama: "Whiskas Adult",
    harga: 40000,
    icon: Icons.pets,
    kategori: "Kucing",
  ),
  Produk(nama: "Me-O Tuna", harga: 35000, icon: Icons.pets, kategori: "Kucing"),
  Produk(
    nama: "Royal Canin Kitten",
    harga: 120000,
    icon: Icons.pets,
    kategori: "Kucing",
  ),
  Produk(
    nama: "Pedigree Adult",
    harga: 50000,
    icon: Icons.pets,
    kategori: "Anjing",
  ),
  Produk(
    nama: "Dog Choize Puppy",
    harga: 45000,
    icon: Icons.pets,
    kategori: "Anjing",
  ),
  Produk(
    nama: "Royal Canin Maxi",
    harga: 150000,
    icon: Icons.pets,
    kategori: "Anjing",
  ),
  Produk(
    nama: "Voer Kenari",
    harga: 15000,
    icon: Icons.flutter_dash,
    kategori: "Burung",
  ),
  Produk(
    nama: "Voer Lovebird",
    harga: 20000,
    icon: Icons.flutter_dash,
    kategori: "Burung",
  ),
  Produk(
    nama: "Voer Murai",
    harga: 25000,
    icon: Icons.flutter_dash,
    kategori: "Burung",
  ),
];

// =======================
// PRODUK PERAWATAN
// =======================
List<Produk> produkPerawatan = [
  Produk(
    nama: "Shampoo Hewan",
    harga: 45000,
    icon: Icons.spa,
    kategori: "Perawatan",
  ),
  Produk(
    nama: "Vitamin Anjing",
    harga: 60000,
    icon: Icons.medical_services,
    kategori: "Perawatan",
  ),
  Produk(
    nama: "Vitamin Kucing",
    harga: 55000,
    icon: Icons.medication,
    kategori: "Perawatan",
  ),
  Produk(
    nama: "Sisir Grooming",
    harga: 30000,
    icon: Icons.cut,
    kategori: "Perawatan",
  ),
  Produk(
    nama: "Obat Kutu",
    harga: 75000,
    icon: Icons.healing,
    kategori: "Perawatan",
  ),
];
