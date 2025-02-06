import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:food_delivery_app/src/app/const/constants.dart';
import 'package:food_delivery_app/src/app/model/food_item.dart';

class CustomerApi {
  static final Dio _dio = Dio();

  static Future<List<FoodItem>> getFood(String type) async {
    if (type == "All") {
      String url = "$BASEURL/getAll";
      try {
        final response = await _dio.get(url);

        if (response.statusCode == 200) {
          List<dynamic> data = response.data;
          return data.map((json) => FoodItem.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load food items');
        }
      } catch (e) {
        print('Error: $e');
        return [];
      }
    } else {
      String url = "$BASEURL/getByCat?category=$type";
      try {
        final response = await _dio.get(url);

        if (response.statusCode == 200) {
          List<dynamic> data = response.data;
          return data.map((json) => FoodItem.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load food items');
        }
      } catch (e) {
        print('Error: $e');
        return [];
      }
    }
  }

  static Future<bool> getAds() async {
    try {
      final response = await _dio.get("$BASEURL/own/ads");

      if (response.statusCode == 200) {
        return response.data["ads"] ?? false;
      } else {
        return false;
      }
    } catch (e) {
      print("Error fetching ads: $e");
      return false;
    }
  }

}
