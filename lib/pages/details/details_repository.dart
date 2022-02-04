import 'dart:convert';

import 'package:eats/const.dart';
import 'package:eats/models/products.dart';
import 'package:http/http.dart' as http;

class DetailsRepository {
  Future<List<Products>> findProductById(int id) async {
    final url = "$acess/products/get/id";
    final response = await http.post(Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: json.encode({"id": id}));
    List<Products> products = [];
    Map map = jsonDecode(response.body);
    if (map.containsKey('products')) {
      map['products'].forEach((p) async {
        products.add(Products.fromJson(p));
      });
      return products;
    } else {
      return [];
    }
  }
}
