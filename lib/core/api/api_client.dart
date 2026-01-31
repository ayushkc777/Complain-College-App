import 'package:dio/dio.dart';

class ApiClient {\n  ApiClient._();\n\n  static const String baseUrl = 'http://10.0.2.2:3000/api/v1';

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}


