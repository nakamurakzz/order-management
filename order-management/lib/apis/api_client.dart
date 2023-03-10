import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:order_management/models/item.dart';

class ApiClient {
  late final Dio dio;
  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:3000',
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<List<Item>> getItems() async {
    // TODO: 動作確認のために1秒待つだけ
    await Future.delayed(const Duration(seconds: 1));
    final response = await dio.get('/items');
    debugPrint(response.toString());
    List<Item> users = List<Item>.from(response.data.map((model) {
      debugPrint(model.toString());
      return Item.fromJson(model);
    }));
    return users;
  }

  Future<bool> postOrder({required Map<int, int> order}) async {
    // Map<int, int> => JSON
    final data = {
      'order': order.map((key, value) => MapEntry(key.toString(), value))
    };

    try {
      final response = await dio.post(
        '/orders',
        data: data,
      );
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

final ApiClient apiClient = ApiClient();
