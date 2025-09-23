import 'package:flutter/material.dart';

class Keranjang {
  String nama;
  String harga;
  IconData? icon;   // untuk food pakai icon
  String? gambar;   // untuk aksesoris/layanan pakai gambar
  int quantity;     // ✅ jumlah item

  Keranjang({
    required this.nama,
    required this.harga,
    this.icon,
    this.gambar,
    this.quantity = 1, // default 1
  });
}
