import 'dart:convert';
import 'package:ecom_flutter/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/products'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
