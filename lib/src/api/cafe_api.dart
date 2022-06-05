// ignore_for_file: prefer_final_fields

import 'package:dio/dio.dart';

class CafeApi {
  static Dio _dio = Dio();

  static void configureDio() async {
    _dio.options.baseUrl = 'https://pokeapi.co/api/v2/pokemon';

    // _dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   'X-Requested-With': 'XMLHttpRequest',
    // };
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);

      return resp.data;
    } catch (e) {
      // print(e);
      throw ('Error en el GET');
    }
  }
}
