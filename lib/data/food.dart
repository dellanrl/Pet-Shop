import 'package:flutter/material.dart';

enum Category { Kucing, Anjing, Burung }

class Food {
  String _name;
  String _price;
  IconData _icon;
  Category category;

  Food({
    required String name,
    required String price,
    required IconData icon,
    required this.category,
  }) : _name = name,
       _price = price,
       _icon = icon;

  String get name => _name;
  String get price => _price;
  IconData get icon => _icon;

  set name(String newName) => _name = newName;
  set price(String newPrice) => _price = newPrice;
  set icon(IconData newIcon) => _icon = newIcon;
}
