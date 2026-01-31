import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:complain_college_app/core/services/storage/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StorageService', () {
    test('set/get string', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final storage = StorageService(prefs: prefs);

      await storage.setString('key', 'value');
      expect(storage.getString('key'), 'value');
    });

    test('saveAuthToken stores token', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final storage = StorageService(prefs: prefs);

      await storage.saveAuthToken('token123');
      expect(storage.getAuthToken(), 'token123');
    });

    test('saveUserJson stores user json', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final storage = StorageService(prefs: prefs);

      await storage.saveUserJson('{"name":"Aayush"}');
      expect(storage.getUserJson(), '{"name":"Aayush"}');
    });

    test('remove clears key', () async {
      SharedPreferences.setMockInitialValues({'temp': 'value'});
      final prefs = await SharedPreferences.getInstance();
      final storage = StorageService(prefs: prefs);

      await storage.remove('temp');
      expect(storage.getString('temp'), isNull);
    });

    test('containsKey returns true when key exists', () async {
      SharedPreferences.setMockInitialValues({'exists': true});
      final prefs = await SharedPreferences.getInstance();
      final storage = StorageService(prefs: prefs);

      expect(storage.containsKey('exists'), isTrue);
    });
  });
}


