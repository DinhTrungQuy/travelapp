// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String username;
  final String fullname;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String imageUrl;

  User({
    this.id = "",
    required this.username,
    this.fullname = "",
    this.email = "",
    this.phone = "",
    required this.password,
    this.role = "user",
    this.imageUrl = "",
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userId'],
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      role: json['role'] ?? "user",
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'imageUrl': imageUrl,
    };
  }
}
