import 'dart:convert';

import 'package:apicubit/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  getProductData() async {
    var url = Uri.https('fakestoreapi.com', 'products');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      print(response.body);
      final List = jsonDecode(response.body);
      return List.map((json) => ProductModel.fromMap(json)).toList;
    } else {
      throw Exception('failed to get ');
    }
  }
}
