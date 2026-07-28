import 'package:dio/dio.dart';
import 'package:watch_app/models/watchcardmodel.dart';

class ApiService {
  final Dio dio = Dio();

  final String baseUrl = "https://dummyjson.com";

  Future<List<Watchcardmodel>> getWatches() async {
    try {
      final response = await dio.get("$baseUrl/products/category/mens-watches");

      List products = response.data['products'];

      return products
          .map((product) => Watchcardmodel.fromJson(product))
          .toList();
    } catch (e) {
      throw Exception('Failed to load watches');
    }
  }
}
