import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorage {
  static const _kEmail = 'profile_email';
  static const _kSelfiePath = 'profile_selfie_path';

  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kEmail, email);
  }

  static Future<void> saveSelfiePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSelfiePath, path);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kEmail);
  }

  static Future<String?> getSelfiePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kSelfiePath);
  }
  static Future<void> clearUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('profile_email');
  await prefs.remove('profile_selfie_path');
}
}
