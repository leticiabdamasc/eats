import 'dart:convert';

import 'package:eats/const.dart';
import 'package:eats/models/company.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  Future<Company> getCompany(int idCompany) async {
    final url = "$acess/company/$idCompany";
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
    );
    final body = response.body;
    Company company = Company.fromJson(json.decode(body));
    print(company);
    return company;
  }
}
