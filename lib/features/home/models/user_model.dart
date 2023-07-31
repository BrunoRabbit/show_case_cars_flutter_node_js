import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.password,
    this.email,
    this.isAdmin,
  });

  int? id;
  final String? name;
  final String? email;
  final String? password;
  bool? isAdmin = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      isAdmin: map['isAdmin'] as bool?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
