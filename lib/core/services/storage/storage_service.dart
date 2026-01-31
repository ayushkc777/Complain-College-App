import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService({required SharedPreferences prefs}) : _prefs = prefs;

  // String
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);\n\n  String getStringOrEmpty(String key) => _prefs.getString(key) ?? '';

  // Int
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);
  int? getInt(String key) => _prefs.getInt(key);

  // Double
  Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);
  double? getDouble(String key) => _prefs.getDouble(key);

  // Bool
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  bool? getBool(String key) => _prefs.getBool(key);

  // StringList
  Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  // Remove & Clear
  Future<bool> remove(String key) => _prefs.remove(key);
  Future<bool> clear() => _prefs.clear();\n\n  Future<void> clearAuth() async {\n    await remove('authToken');\n    await remove('refreshToken');\n    await remove('currentUser');\n  }

  // Check if key exists
  bool containsKey(String key) => _prefs.containsKey(key);

  // Auth helpers
  Future<void> saveAuthToken(String token) async {
    await setString('authToken', token);
  }

  String? getAuthToken() => getString('authToken');\n\n  Future<void> removeAuthToken() async {\n    await remove('authToken');\n  }

  Future<void> saveUserJson(String json) async {
    await setString('currentUser', json);
  }

  String? getUserJson() => getString('currentUser');\n\n  Future<void> removeUserJson() async {\n    await remove('currentUser');\n  }\n\n  Future<void> saveRefreshToken(String token) async {\n    await setString('refreshToken', token);\n  }\n\n  String? getRefreshToken() => getString('refreshToken');
}






