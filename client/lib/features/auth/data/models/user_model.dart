import 'package:client/features/auth/domain/entities/user.dart';

class UserModel {
  final String? id;
  final String email;
  UserModel({required this.id, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], email: json['email']);
  }
  User toEntity() {
    return User(email: email, id: id);
  }
}
