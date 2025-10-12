import 'package:flutter/material.dart';
import 'keranjang.dart';

class Keranjang {
  final String nama;
  final int harga;
  final IconData? icon;
  final String? gambar;
  int jumlah;

  Keranjang({
    required this.nama,
    required this.harga,
    this.icon,
    this.gambar,
    this.jumlah = 1,
  });
}

List<Keranjang> globalCart = [];
