import 'package:flutter/material.dart';

class Produk {
  String _nama;
  String _harga;
  IconData _icon;
  String _kategori;

  Produk({
    required String nama,
    required String harga,
    required IconData icon,
    required String kategori,
  })  : _nama = nama,
        _harga = harga,
        _icon = icon,
        _kategori = kategori;

  // === Getter ===
  String get nama => _nama;
  String get harga => _harga;
  IconData get icon => _icon;
  String get kategori => _kategori;

  // === Setter ===
  set nama(String value) => _nama = value;
  set harga(String value) => _harga = value;
  set icon(IconData value) => _icon = value;
  set kategori(String value) => _kategori = value;
}

List<Produk> produkMakanan = [
  Produk(
    nama: "Whiskas Adult",
    harga: "Rp 40.000",
    icon: Icons.pets,
    kategori: "Kucing",
  ),
  Produk(
    nama: "Me-O Tuna",
    harga: "Rp 35.000",
    icon: Icons.pets,
    kategori: "Kucing",
  ),
  Produk(
    nama: "Royal Canin Kitten",
    harga: "Rp 120.000",
    icon: Icons.pets,
    kategori: "Kucing",
  ),
  Produk(
    nama: "Pedigree Adult",
    harga: "Rp 50.000",
    icon: Icons.pets,
    kategori: "Anjing",
  ),
  Produk(
    nama: "Dog Choize Puppy",
    harga: "Rp 45.000",
    icon: Icons.pets,
    kategori: "Anjing",
  ),
  Produk(
    nama: "Royal Canin Maxi",
    harga: "Rp 150.000",
    icon: Icons.pets,
    kategori: "Anjing",
  ),
  Produk(
    nama: "Voer Kenari",
    harga: "Rp 15.000",
    icon: Icons.flutter_dash,
    kategori: "Burung",
  ),
  Produk(
    nama: "Voer Lovebird",
    harga: "Rp 20.000",
    icon: Icons.flutter_dash,
    kategori: "Burung",
  ),
  Produk(
    nama: "Voer Murai",
    harga: "Rp 25.000",
    icon: Icons.flutter_dash,
    kategori: "Burung",
  ),
];

// ==== DATA PRODUK PERAWATAN ====
List<Produk> produkPerawatan = [
  Produk(
    nama: "Shampoo Hewan",
    harga: "Rp 45.000",
    icon: Icons.spa,
    kategori: "Perawatan",
  ),
  Produk(
    nama: "Vitamin Anjing",
    harga: "Rp 60.000",
    icon: Icons.medical_services,
    kategori: "Perawatan",
  ),
  Produk(
    nama: "Vitamin Kucing",
    harga: "Rp 55.000",
    icon: Icons.medication,
    kategori: "Perawatan",
  ),
  Produk(
    nama: "Sisir Grooming",
    harga: "Rp 30.000",
    icon: Icons.cut,
    kategori: "Perawatan",
  ),
  Produk(
    nama: "Obat Kutu",
    harga: "Rp 75.000",
    icon: Icons.healing,
    kategori: "Perawatan",
  ),
];
