class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? role;

  User({
    this.id,
    this.name,
    required this.email,
    required this.password,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'],
    );
  }
}
