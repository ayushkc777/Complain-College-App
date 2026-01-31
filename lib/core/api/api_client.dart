import 'package:dio/dio.dart';

class ApiClient {\n  ApiClient._();\n\n  static const String baseUrl = 'http://10.0.2.2:3000/api/v1';\n  static const int connectTimeoutSeconds = 15;\n  static const int receiveTimeoutSeconds = 20;\n\n  static const Map<String, String> defaultHeaders = {\n    'Content-Type': 'application/json',\n    'Accept': 'application/json',\n  };

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: connectTimeoutSeconds),
      receiveTimeout: const Duration(seconds: receiveTimeoutSeconds),
      headers: defaultHeaders,
    ),
  );
}




