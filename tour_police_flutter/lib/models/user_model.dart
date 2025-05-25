class UserModel {
  final String username;
  final String email;
  final String? phone;
  final String? bio;

  UserModel({
    required this.username,
    required this.email,
    this.phone,
    this.bio,
  });

  // Для парсинга JSON из ответа сервера
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      phone: json['phone_number'],
      bio: json['bio'],
    );
  }
}