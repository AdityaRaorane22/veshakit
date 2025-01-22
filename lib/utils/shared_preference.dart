import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static const String _usernameKey = "username";

  // Save username in SharedPreferences
  static Future<void> saveUsername(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  // Get username from SharedPreferences
  static Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // Clear username from SharedPreferences
  static Future<void> clearUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
  }
}
