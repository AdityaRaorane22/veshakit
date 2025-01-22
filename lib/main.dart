import 'package:flutter/material.dart';
import 'package:parkly/screens/login.dart';
import 'package:parkly/screens/profile.dart';
import 'package:parkly/screens/signup.dart';
import 'package:parkly/screens/home.dart';

void main() {
  runApp(const ParkioApp());
}

class ParkioApp extends StatelessWidget {
  const ParkioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parkio',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/home': (context) => const Home(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}
