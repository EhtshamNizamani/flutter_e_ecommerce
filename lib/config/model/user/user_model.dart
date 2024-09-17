class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String accessToken;
  final String refreshToken;
  final int version;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.refreshToken,
    required this.accessToken,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }
}
