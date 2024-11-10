import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future getRevenue() async {
  final baseUrl = dotenv.env['API_URL']!;
  var url = Uri.parse(baseUrl + '/sales/total-revenue');

  final response = await http.get(url);
  if (jsonDecode(response.body)['code'] == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception('Failed to load revenue');
  }
}
