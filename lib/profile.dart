import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/user_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                currentUser.username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Email",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(currentUser.email),
            const SizedBox(height: 16),
            const Text(
              "Phone",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(currentUser.phone),
            const SizedBox(height: 16),
            const Text(
              "Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(currentUser.address),
          ],
        ),
      ),
    );
  }
}
