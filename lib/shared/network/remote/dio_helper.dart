import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    //I made it static for getting to a function named"getData" directly by the class named"DioHelper"
    @required String url,
    @required Map<String,dynamic> query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }
}
