import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/user_data.dart';
import '/data/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User user = currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color.fromARGB(255, 131, 201, 237),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedUser = await Navigator.push<User>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(user: user),
                ),
              );

              if (updatedUser != null) {
                setState(() {
                  currentUser = updatedUser; 
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromARGB(255, 131, 196, 236),
                backgroundImage: const AssetImage("assets/images/profile.jpg"),
                onBackgroundImageError: (_, __) {
                  debugPrint("Gagal memuat gambar profil");
                },
              ),
            ),
            const SizedBox(height: 20),
            buildProfileItem(Icons.person, "Username", user.username),
            buildProfileItem(Icons.email, "Email", user.email),
            buildProfileItem(Icons.phone, "Phone", user.phone),
            buildProfileItem(Icons.home, "Address", user.address),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 118, 195, 243),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Kembali",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 148, 204, 245),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 24, 24, 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(value, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user.username);
    emailController = TextEditingController(text: widget.user.email);
    phoneController = TextEditingController(text: widget.user.phone);
    addressController = TextEditingController(text: widget.user.address);
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color.fromARGB(255, 131, 201, 237),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField("Username", usernameController),
            buildTextField("Email", emailController),
            buildTextField("Phone", phoneController),
            buildTextField("Address", addressController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedUser = User(
                  username: usernameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                );

                Navigator.pop(context, updatedUser);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 118, 195, 243),
              ),
              child: const Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
