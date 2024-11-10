import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:store_management/models/product_model.dart';
import 'package:store_management/routes/routes.dart';

Future getAllProduct(String? search) async {
  final baseUrl = dotenv.env['API_URL']!;
  var url = Uri.parse(baseUrl + '/products');

  if (search != null) {
    url = Uri.parse(baseUrl + '/products?search=$search');
  }

  final response = await http.get(url);
  if (jsonDecode(response.body)['code'] == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    print('produk data: $data');
    List<ProductModel> products =
        data.map((e) => ProductModel.fromJson(e)).toList();

    print('produk: $products');
    return products;
  } else {
    throw Exception(jsonDecode(response.body)['message']);
  }
}

Future createProduct(
  String name,
  String? description,
  File? image,
  int price,
  int stock,
) async {
  final baseUrl = dotenv.env['API_URL']!;
  var url = Uri.parse(baseUrl + '/products');

  print({
    'name': name,
    'price': price,
    'description': description,
    'stock': stock,
    'image': image,
  });

  try {
    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url.toString()));

    // Add fields
    request.fields['name'] = name;
    request.fields['price'] = price.toString();
    request.fields['description'] = description.toString();
    request.fields['stock'] = stock.toString();

    // Attach the file (image)
    if (image != null && image.path.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: MediaType('image', 'png'),
        ),
      );
    }

    // Send the request and get the response
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Product created successfully!');
      var responseBody = await response.stream.bytesToString();
      print('Response: $responseBody');
      Get.offAllNamed(Routes.home);
    } else {
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
      var responseJson = jsonDecode(responseBody);
      throw Exception(responseJson['message']);
    }
  } catch (e) {
    print('Error occurred: $e');
    throw Exception(e.toString());
  }
}
