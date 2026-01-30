import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();

  static const String usersBoxName = 'users';
  static const String sessionBoxName = 'session';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(usersBoxName);
    await Hive.openBox(sessionBoxName);
  }

  static Box get _usersBox => Hive.box(usersBoxName);
  static Box get _sessionBox => Hive.box(sessionBoxName);

  static Map<String, dynamic>? getUserByEmail(String email) {
    final key = email.trim().toLowerCase();
    final data = _usersBox.get(key);
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  static bool userExists(String email) {
    final key = email.trim().toLowerCase();
    return _usersBox.containsKey(key);
  }

  static Future<void> saveUser(Map<String, dynamic> user) async {
    final email = (user['email'] ?? '').toString().trim().toLowerCase();
    if (email.isEmpty) return;
    await _usersBox.put(email, user);
  }

  static Future<void> setCurrentUser(Map<String, dynamic> user) async {
    await _sessionBox.put('currentUser', user);
  }

  static Map<String, dynamic>? getCurrentUser() {
    final data = _sessionBox.get('currentUser');
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return null;
  }

  static Future<void> clearSession() async {
    await _sessionBox.delete('currentUser');
  }
}

