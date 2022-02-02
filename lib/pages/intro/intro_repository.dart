import 'package:eats/models/company.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../const.dart';

class IntroRepository {
  Future<List<Company>> getCompanies() async {
    final url = acess + '/company/all';
    final response = await http
        .get(Uri.parse(url), headers: {'Content-type': 'application/json'});
    Map map = jsonDecode(response.body);
    List<Company> company = [];
    if (map.containsKey('companies')) {
      map['companies'].forEach((c) async {
        company.add(Company.fromJson(c));
      });
      return company;
    } else {
      return [];
    }
  }
}
