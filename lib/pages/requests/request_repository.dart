import 'dart:convert';

import '../../const.dart';
import 'package:http/http.dart' as http;

class RequestRepository {
  Future<int> sendRequest(double value, String nameUser, String street,
      int number, String district, String city, int cep, String pay) async {
    final url = "$acess/request/send";
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
      body: json.encode({
        "value": value,
        "nameUser": nameUser,
        "street": street,
        "district": district,
        "city": city,
        "cep": cep,
        "pay": pay
      }),
    );
    Map map = jsonDecode(response.body);
    print(map);
    if (map['affectedRows'] == 1) {
      return 1;
    } else {
      return 0;
    }
  }
}
