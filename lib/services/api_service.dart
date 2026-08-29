import 'package:dio/dio.dart';
import 'package:watch_app/models/watchcardmodel.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  final String baseUrl = "https://dummyjson.com";

  Future<List<WatchCardModel>> getWatches() async {
    try {
      final response = await dio.get("$baseUrl/products/category/mens-watches");

      if (response.statusCode == 200 && response.data != null && response.data['products'] is List) {
        List products = response.data['products'];
        return products
            .map((product) => WatchCardModel.fromJson(product))
            .toList();
      }
      return getFallbackWatches();
    } catch (_) {
      return getFallbackWatches();
    }
  }

  static List<WatchCardModel> getFallbackWatches() {
    return const [
      WatchCardModel(
        id: 101,
        title: "Apple Watch Series",
        brand: "Apple",
        price: 350.0,
        thumbnail: "assets/images/applewatchh.png",
        images: ["assets/images/applewatchh.png"],
        rating: 4.8,
        description: "Advanced health features and brilliant Retina screen display.",
      ),
      WatchCardModel(
        id: 102,
        title: "Galaxy Watch Active",
        brand: "Samsung",
        price: 280.0,
        thumbnail: "assets/images/samsongwatch.png",
        images: ["assets/images/samsongwatch.png"],
        rating: 4.6,
        description: "Sleek smartwatch designed for active fitness and lifestyle tracking.",
      ),
      WatchCardModel(
        id: 103,
        title: "Bremont Chronometer",
        brand: "Bremont",
        price: 450.0,
        thumbnail: "assets/images/Bremont.png",
        images: ["assets/images/Bremont.png"],
        rating: 4.9,
        description: "Precision engineered British mechanical chronometer timepiece.",
      ),
      WatchCardModel(
        id: 104,
        title: "Fossil Townsman",
        brand: "Fossil",
        price: 195.0,
        thumbnail: "assets/images/FOSSIL.png",
        images: ["assets/images/FOSSIL.png"],
        rating: 4.5,
        description: "Classic analog watch with genuine leather strap and chronograph movement.",
      ),
      WatchCardModel(
        id: 105,
        title: "Tommy Hilfiger Decker",
        brand: "Tommy Hilfiger",
        price: 220.0,
        thumbnail: "assets/images/TommyHilfigerDecker.png",
        images: ["assets/images/TommyHilfigerDecker.png"],
        rating: 4.7,
        description: "Sporty stainless steel watch with multi-function sub-dials.",
      ),
      WatchCardModel(
        id: 106,
        title: "Zurich Mauriac Swiss",
        brand: "Mauriac",
        price: 520.0,
        thumbnail: "assets/images/ZurichMauriacSwiss.png",
        images: ["assets/images/ZurichMauriacSwiss.png"],
        rating: 4.9,
        description: "Swiss made luxury timepiece with sapphire crystal glass.",
      ),
    ];
  }
}
