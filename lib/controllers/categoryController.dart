import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sarpras_mobile/models/category.dart';

const String CategoryApi = 'http://127.0.0.1:8000/api/categories';

Dio dio = Dio();

Future<List<CategoryModel>> fetchCategories() async {
  try {
    final response = await dio.get(CategoryApi);
    if (response.statusCode == 200) {
      print('fetched categorys succesfully 200');
      final data = response.data['categories'];
      return data
          .map<CategoryModel>((category) => CategoryModel.fromJson(category))
          .toList();
    } else {
      print("failed to load categories");
      throw Exception('Failed to load categories: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching categories: $e');
    throw Exception('Error fetching Items dumbass: $e');
  }
}

List<CategoryModel> parseItems(dynamic responseBody) {
  final Map<String, dynamic> jsonResponse = json.decode(responseBody);
  final List<dynamic> data = jsonResponse['categories'];
  return data.map((category) => CategoryModel.fromJson(category)).toList();
}
