import 'package:flutter/material.dart';

class Produk {
  String _nama;
  int _harga; 
  IconData _icon;
  String _kategori;

  Produk({
    required String nama,
    required int harga,
    required IconData icon,
    required String kategori,
  }) : _nama = nama,
       _harga = harga,
       _icon = icon,
       _kategori = kategori;

  String get nama => _nama;
  int get harga => _harga;
  IconData get icon => _icon;
  String get kategori => _kategori;

  set nama(String value) => _nama = value;
  set harga(int value) => _harga = value;
  set icon(IconData value) => _icon = value;
  set kategori(String value) => _kategori = value;
}

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
