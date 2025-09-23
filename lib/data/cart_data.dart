import 'package:flutter/material.dart';

class Keranjang {
  final String nama;
  final String harga;
  final IconData? icon;
  final String? gambar;

  Keranjang({
    required this.nama,
    required this.harga,
    this.icon,
    this.gambar,
  });
}

// List keranjang global
List<Keranjang> globalCart = [];
