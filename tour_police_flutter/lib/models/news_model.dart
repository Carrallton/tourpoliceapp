class NewsModel {
  final String id;
  final String title;
  final String content;
  final String imageUrl;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['_id'] ?? '',
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'] ?? 'https://via.placeholder.com/600x400 ',
    );
  }
}