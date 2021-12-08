import 'package:dio/dio.dart';

class GlobalDio {
  late Dio dio;

  GlobalDio() {
    configDio();
  }

  void configDio() {
    dio = Dio();
    dio.options.baseUrl = 'https://pokeapi.co/api/v2/';

    // dio.options.connectTimeout = 10000; //5s
    // dio.options.receiveTimeout = 10000;
  }
}
