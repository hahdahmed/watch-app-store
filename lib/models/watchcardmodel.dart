class WatchCardModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final List<String> images;
  final double rating;
  final String brand;

  const WatchCardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.rating,
    required this.brand,
  });

  factory WatchCardModel.fromJson(Map<String, dynamic> json) {
    return WatchCardModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title']?.toString() ?? 'Watch',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail']?.toString() ?? '',
      images: json['images'] is List
          ? (json['images'] as List).map((e) => e.toString()).toList()
          : <String>[],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      brand: json['brand']?.toString() ?? 'Watch Brand',
    );
  }
}

/// Backwards-compatibility alias for previous naming conventions.
typedef Watchcardmodel = WatchCardModel;
