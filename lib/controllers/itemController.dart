import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sarpras_mobile/models/item.dart';

const String ItemApi = 'http://127.0.0.1:8000/api/items';

Dio dio = Dio();

Future<List<ItemModel>> fetchItems() async {
  try {
    final response = await dio.get(ItemApi);
    if (response.statusCode == 200) {
      print('fetched items succesfully 200');
      final data = response.data['items'];
      return data.map<ItemModel>((item) => ItemModel.fromJson(item)).toList();
    } else {
      print("failed to load items");
      throw Exception('Failed to load items: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching items: $e');
    throw Exception('Error fetching Items dumbass: $e');
  }
}

List<ItemModel> parseItems(dynamic responseBody) {
  final Map<String, dynamic> jsonResponse = json.decode(responseBody);
  final List<dynamic> data = jsonResponse['items'];
  return data.map((item) => ItemModel.fromJson(item)).toList();
}
