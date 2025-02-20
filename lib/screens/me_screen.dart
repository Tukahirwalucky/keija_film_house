import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  String? _username = "User Name";
  String? _bio = "Write something about yourself...";
  String? _profileImagePath;
  List<String> _transactions = [
    "Paid UGX 1,000 for The Matron",
    "Paid UGX 1,000 for The Passenger"
  ];
  List<String> _downloads = ["The Matron", "The Passenger"];

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Load stored data from SharedPreferences
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? "User Name";
      _bio = prefs.getString('bio') ?? "Write something about yourself...";
      _profileImagePath = prefs.getString('profileImage');
    });
  }

  // Save data to SharedPreferences
  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _username!);
    await prefs.setString('bio', _bio!);
    if (_profileImagePath != null) {
      await prefs.setString('profileImage', _profileImagePath!);
    }
  }

  // Pick an image from gallery for profile picture
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path;
      });
      _saveProfileData();
    }
  }

  // Edit username and bio
  void editProfile() {
    TextEditingController nameController =
        TextEditingController(text: _username);
    TextEditingController bioController = TextEditingController(text: _bio);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Username")),
            TextField(
                controller: bioController,
                decoration: InputDecoration(labelText: "Biography")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _username = nameController.text;
                _bio = bioController.text;
              });
              _saveProfileData();
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture Section
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: _profileImagePath != null
                    ? FileImage(File(_profileImagePath!))
                    : null,
                child: _profileImagePath == null
                    ? Icon(Icons.camera_alt, color: Colors.white, size: 40)
                    : null,
              ),
            ),
            SizedBox(height: 10),
            Text(
              _username!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              _bio!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 20),

            // Transactions Section
            _buildSectionTitle("Transactions"),
            _buildListSection(_transactions),

            // Downloads Section
            _buildSectionTitle("Downloaded Movies"),
            _buildListSection(_downloads),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // List of items (transactions & downloads)
  Widget _buildListSection(List<String> items) {
    return items.isEmpty
        ? Text("No data available", style: TextStyle(color: Colors.white70))
        : Column(
            children: items
                .map((item) => ListTile(
                      title: Text(item, style: TextStyle(color: Colors.white)),
                      leading: Icon(Icons.movie, color: Colors.white),
                    ))
                .toList(),
          );
  }
}
