import 'dart:convert';
import 'package:flutter/services.dart';

class TestAssetBundle extends CachingAssetBundle {
  static const String _svg =
      '<svg viewBox="0 0 10 10" xmlns="http://www.w3.org/2000/svg">'
      '<circle cx="5" cy="5" r="5" />'
      '</svg>';

  @override
  Future<ByteData> load(String key) async {
    final bytes = Uint8List.fromList(utf8.encode(_svg));
    return ByteData.view(bytes.buffer);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return _svg;
  }
}

