import 'package:dio/dio.dart';

class ApiClient {\n  ApiClient._();\n\n  static const String baseUrl = 'http://10.0.2.2:3000/api/v1';\n  static const int connectTimeoutSeconds = 15;\n  static const int receiveTimeoutSeconds = 20;

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: connectTimeoutSeconds),
      receiveTimeout: const Duration(seconds: receiveTimeoutSeconds),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}



