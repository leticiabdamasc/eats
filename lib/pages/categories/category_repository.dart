import 'dart:convert';

import 'package:eats/const.dart';
import 'package:eats/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  Future<List<Category>> getAllCategories() async {
    final url = "$acess/category/all";
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
    );
    List<Category> cat = [];
    Map map = jsonDecode(response.body);
    if (map.containsKey('category')) {
      map['category'].forEach((c) async {
        cat.add(Category.fromJson(c));
      });
      return cat;
    } else {
      return [];
    }
  }

  Future<List<Category>> getCategoryCompany(int idCompany) async {
    final url = "$acess/category/company";
    final response = await http.post(Uri.parse(url),
        headers: {'Content-type': 'application/json'},
        body: json.encode({"id": idCompany}));
    List<Category> cat = [];
    Map map = jsonDecode(response.body);
    if (map.containsKey('category')) {
      map['category'].forEach((c) async {
        cat.add(Category.fromJson(c));
      });
      return cat;
    } else {
      return [];
    }
  }
}
