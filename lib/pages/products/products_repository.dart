import 'dart:convert';

import 'package:eats/models/products.dart';

import '../../const.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {
  Future<List<Products>> getTopProducts() async {
    final url = "$acess/products/get/top";
    final response = await http
        .post(Uri.parse(url), headers: {'Content-type': 'application/json'});
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

  Future<List<Products>> getTopProductsByCategory(int id) async {
    final url = "$acess/products/get/top/company";
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
