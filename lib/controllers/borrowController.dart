import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sarpras_mobile/models/request.dart';

const String borrowApi = 'http://127.0.0.1:8000/api/borrows';

Dio dio = Dio();

Future<List<ItemRequest>> fetchBorrows() async {
  try {
    final response = await dio.get(borrowApi);
    if (response.statusCode == 200) {
      print('fetched borrows succesfull');
      final data = response.data['data'];
      return data
          .map<ItemRequest>((borrows) => ItemRequest.fromJson(borrows))
          .toList();
    } else {
      print('failed to load borrows');
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching categories: $e');
    throw Exception('Error fetching Items in fetch borrows dumbass: $e');
  }
}

List<ItemRequest> parseItems(dynamic responseBody) {
  final Map<String, dynamic> jsonRepsonse = json.decode(responseBody);
  final List<dynamic> data = jsonRepsonse['data'];
  return data.map((borrows) => ItemRequest.fromJson(borrows)).toList();
}

Future<List<ItemRequest>> fetchBorrowsByItem(int itemId) async {
  String itemBorrowApi = 'http://127.0.0.1:8000/api/borrows/item/$itemId';
  try {
    final response = await dio.get(itemBorrowApi);
    if (response.statusCode == 200) {
      print('fetched borrows succesfull');
      final data = response.data['data'];
      return data
          .map<ItemRequest>(
            (borrowsByItem) => ItemRequest.fromJson(borrowsByItem),
          )
          .toList();
    } else {
      print('failed to load borrows');
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching items by id: $e');
    throw Exception('Error fetching Items borrows by item id dumbass: $e');
  }
}
