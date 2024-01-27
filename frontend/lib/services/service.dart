import 'package:dio/dio.dart';

abstract class Service {
  Dio getDio() {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'http://localhost:3000',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    return dio;
  }
}