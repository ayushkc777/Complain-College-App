import 'package:hive_flutter/hive_flutter.dart';

class HiveService {\n  HiveService._();\n\n  static bool _initialized = false;\n
  static const String usersBoxName = 'users';
  static const String sessionBoxName = 'session';

  static Future<void> init() async {\n    if (_initialized) return;\n    await Hive.initFlutter();
    await Hive.openBox(usersBoxName);
    await Hive.openBox(sessionBoxName);\n    _initialized = true;\n  }

  static Box get _usersBox => Hive.box(usersBoxName);
  static Box get _sessionBox => Hive.box(sessionBoxName);\n\n  static bool get isReady => _initialized;\n\n  static Future<void> ensureInitialized() async {\n    if (!_initialized) {\n      await init();\n    }\n  }

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

  static Future<void> clearSession() async {\n    await _sessionBox.delete('currentUser');\n  }\n\n  static Future<void> close() async {\n    await Hive.close();\n    _initialized = false;\n  }\n}\n





