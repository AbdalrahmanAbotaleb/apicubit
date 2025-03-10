import 'dart:convert';
import 'package:apicubit/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Future<List<ProductModel>> getProductData() async {
    var url = Uri.https('fakestoreapi.com', 'products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => ProductModel.fromMap(json)).toList();
    } else {
      throw Exception('Failed to get data');
    }
  }
}
