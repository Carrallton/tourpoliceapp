// lib/models/place_model.dart
class PlaceModel {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String category;
  final String? imageUrl;

  PlaceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.category,
    this.imageUrl,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['_id'] ?? '',
      name: json['name'],
      description: json['description'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      category: json['category'],
      imageUrl: json['image_url'],
    );
  }
}