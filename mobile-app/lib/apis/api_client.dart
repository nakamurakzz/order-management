import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
    // Delay for 3 seconds to simulate network latency
    await Future.delayed(const Duration(seconds: 3));
    final response = await dio.get('/items');
    debugPrint(response.toString());
    List<Item> users = List<Item>.from(response.data.map((model) {
      debugPrint(model.toString());
      return Item.fromJson(model);
    }));
    return users;
  }
}

final ApiClient apiClient = ApiClient();

// APIレスポンスのモデル
// Itemはid, title, subtitle, priceプロパティを持つ
class Item {
  final int id;
  final String title;
  final String subtitle;
  final int price;
  final int itemTypeId;
  Item({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.itemTypeId,
  });
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      subtitle: json['subTitle'],
      price: json['price'],
      itemTypeId: json['itemTypeId'],
    );
  }
}
