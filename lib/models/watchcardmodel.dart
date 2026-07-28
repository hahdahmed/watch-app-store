class Watchcardmodel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final List<String> images;
  final double rating;
  final String brand;

  Watchcardmodel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.rating,
    required this.brand,
  });

  factory Watchcardmodel.fromJson(Map<String, dynamic> json) {
    return Watchcardmodel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
      rating: (json['rating'] as num).toDouble(),
      brand: json['brand'],
    );
  }
}
