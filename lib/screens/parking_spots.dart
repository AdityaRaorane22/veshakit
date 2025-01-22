import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ParkingSpots extends StatelessWidget {
  const ParkingSpots({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LatLng> parkingSpots = [
      LatLng(37.7749, -122.4194), // San Francisco
      LatLng(34.0522, -118.2437), // Los Angeles
      LatLng(40.7128, -74.0060),  // New York
      LatLng(51.5074, -0.1278),   // London
      LatLng(48.8566, 2.3522),    // Paris
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Parking Spots"),
        backgroundColor: Colors.green,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(37.7749, -122.4194),
          zoom: 10,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: parkingSpots.map((spot) {
              return Marker(
                point: spot,
                builder: (ctx) => GestureDetector(
                  onTap: () {
                    // Show dialog when marker is tapped
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Book Parking Spot"),
                          content: Text("Do you want to book this parking spot?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Parking spot booked!")),
                                );
                              },
                              child: const Text("Book"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.local_parking, color: Colors.green),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
