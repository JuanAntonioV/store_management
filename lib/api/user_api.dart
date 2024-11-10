import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:store_management/models/user_model.dart';

Future createUser(UserModel user) async {
  final baseUrl = dotenv.env['API_URL']!;
  var url = Uri.parse(baseUrl + '/users');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );

  print(response.body);

  if (jsonDecode(response.body)['code'] == 201 ||
      jsonDecode(response.body)['code'] == 200) {
    final data = jsonDecode(response.body)['data'];
    return data;
  } else {
    throw Exception(jsonDecode(response.body)['message']);
  }
}

Future getUserByEmail(String email) async {
  final baseUrl = dotenv.env['API_URL']!;
  var url = Uri.parse(baseUrl + '/users/$email');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['data'];
    UserModel user = UserModel.fromJson(data);
    return user;
  } else {
    throw Exception(jsonDecode(response.body)['message']);
  }
}

Future updateUser(String name, String email, File? photo) async {
  final baseUrl = dotenv.env['API_URL']!;
  var url = Uri.parse(baseUrl + '/users/update/$email');

  var request = http.MultipartRequest('POST', Uri.parse(url.toString()));

  request.fields['name'] = name;
  request.fields['email'] = email;

  if (photo != null && photo.path.isNotEmpty) {
    request.files.add(
      http.MultipartFile(
        'photo',
        photo.readAsBytes().asStream(),
        photo.lengthSync(),
        filename: photo.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
  }

  final response = await request.send();

  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = jsonDecode(await response.stream.bytesToString());
    UserModel user = UserModel.fromJson(data);
    return user;
  } else {
    throw Exception(
        jsonDecode(await response.stream.bytesToString())['message']);
  }
}
