import 'package:flutter/material.dart';
import 'package:parkly/utils/shared_preference.dart'; // Import SharedPreferenceUtil
import 'profile.dart'; // Make sure this import is correct
import 'parking_spots.dart'; // Import parking_spots.dart

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parkio"),
        backgroundColor: Colors.green,
        actions: [
          // Profile Icon in the top-right corner
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                "Parkio Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _drawerItem(
              context,
              icon: Icons.local_parking,
              title: "Parking Spots",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ParkingSpots()),
                );
              },
            ),
            _drawerItem(
              context,
              icon: Icons.directions_car,
              title: "My Parkings",
            ),
            _drawerItem(
              context,
              icon: Icons.add_box,
              title: "List a Parking",
            ),
            _drawerItem(
              context,
              icon: Icons.info,
              title: "About",
            ),
            _drawerItem(
              context,
              icon: Icons.logout,
              title: "Logout",
              onTap: () async {
                // Clear username from SharedPreferences and navigate to login page
                await SharedPreferenceUtil.clearUsername();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Smart Parking with Parkio",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              _featureItem(
                icon: Icons.location_on,
                text: "Find parking spots near you.",
              ),
              _featureItem(
                icon: Icons.calendar_today,
                text: "Reserve spots in advance.",
              ),
              _featureItem(
                icon: Icons.history,
                text: "Manage your parking history.",
              ),
              _featureItem(
                icon: Icons.share,
                text: "List your parking spaces for others.",
              ),
              _featureItem(
                icon: Icons.payment,
                text: "Easy and secure payments.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer Item Builder
  Widget _drawerItem(BuildContext context, {required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap ?? () {
        Navigator.pop(context);
      },
    );
  }

  // Feature Item Builder
  Widget _featureItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
