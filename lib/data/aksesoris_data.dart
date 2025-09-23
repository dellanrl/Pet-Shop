import 'aksesoris_data.dart';

class Item {
  final String name;
  final double price;

  Item({required this.name, required this.price});
}

class Accessory extends Item {
  Accessory({required String name, required double price}) : super(name: name, price: price);
}

class Equipment extends Item {
  Equipment({required String name, required double price}) : super(name: name, price: price);
}


