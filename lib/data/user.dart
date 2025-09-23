import 'package:flutter/material.dart';

class User {
  String _username;
  String _email;
  String _phone;
  String _address;

  User({
    required String username,
    required String email,
    required String phone,
    required String address,
  }) : _username = username,
       _email = email,
       _phone = phone,
       _address = address;


  String get username => _username;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;


  set username(String newUsername) => _username = newUsername;
  set email(String newEmail) => _email = newEmail;
  set phone(String newPhone) => _phone = newPhone;
  set address(String newAddress) => _address = newAddress;
}
