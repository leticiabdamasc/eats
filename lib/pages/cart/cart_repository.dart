import 'dart:convert';

import 'package:eats/models/carts.dart';

import '../../const.dart';
import 'package:http/http.dart' as http;

class CartReposiory {
  Future<int> insertIntoCart(
      double value, int quantity, String product, int idProd) async {
    final url = "$acess/cart/send";
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
      body: json.encode({
        "value": value,
        "quantity": quantity,
        "product": product,
        "idProd": idProd
      }),
    );
    Map map = jsonDecode(response.body);

    if (map['affectedRows'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<List<Cart>> getCart() async {
    final url = "$acess/cart/get";
    final response = await http
        .get(Uri.parse(url), headers: {'Content-type': 'application/json'});
    Map map = jsonDecode(response.body);
    List<Cart> carts = [];
    if (map.containsKey("carts")) {
      map['carts'].forEach((c) {
        carts.add(Cart.fromJson(c));
      });
      return carts;
    } else {
      return [];
    }
  }

  Future<String> getTotal() async {
    final url = "$acess/cart/total";
    final response = await http
        .get(Uri.parse(url), headers: {'Content-type': 'application/json'});
    Map map = jsonDecode(response.body);

    return map['value']['SUM(value)'];
  }

  clearCart() async {
    final url = "$acess/cart/clean";
    final response = await http
        .delete(Uri.parse(url), headers: {'Content-type': 'application/json'});
    Map map = jsonDecode(response.body);
  }
}
