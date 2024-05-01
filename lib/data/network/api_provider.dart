import 'dart:io';
import 'package:connectivity_packages/data/models/currency.dart';
import 'package:connectivity_packages/data/network/response/response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  Future<NetworkResponse> getAllCurrencies() async {
    NetworkResponse networkResponse = NetworkResponse();
    Dio dio = Dio();
    try {
      Response response =
          await dio.get("https://nbu.uz/en/exchange-rates/json/");

      if (response.statusCode == HttpStatus.ok) {
        networkResponse.data = (response.data as List?)
                ?.map((e) => CurrencyModel.fromJson(e))
                .toList() ??
            [];
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    return networkResponse;
  }
}
