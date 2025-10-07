import 'package:flutter/material.dart';

class Keranjang {
  String nama;
  String harga;
  IconData? icon;   
  String? gambar;  
  int quantity;     

  Keranjang({
    required this.nama,
    required this.harga,
    this.icon,
    this.gambar,
    this.quantity = 1, 
  });
}
