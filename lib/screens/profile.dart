import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? userDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString("username");

    if (username != null) {
      final url = Uri.parse("http://localhost:5000/user/$username");
      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          setState(() {
            userDetails = jsonDecode(response.body);
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to load user details")),
          );
        }
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching user details: $error")),
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No user logged in")),
      );
    }
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("username");

    // Navigate to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userDetails != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "User Profile",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Name: ${userDetails!['name']}"),
                      const SizedBox(height: 10),
                      Text("Gender: ${userDetails!['gender']}"),
                      const SizedBox(height: 10),
                      Text("Date of Birth: ${userDetails!['dob']}"),
                      const SizedBox(height: 10),
                      Text("Mobile: ${userDetails!['mobile']}"),
                      const SizedBox(height: 10),
                      Text("Address: ${userDetails!['address']}"),
                      const SizedBox(height: 10),
                      Text("Email: ${userDetails!['email']}"),
                      const SizedBox(height: 10),
                      Text("Username: ${userDetails!['username']}"),
                    ],
                  ),
                )
              : const Center(
                  child: Text("No user details available"),
                ),
    );
  }
}
