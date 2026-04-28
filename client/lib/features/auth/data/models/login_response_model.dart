import 'package:client/features/auth/data/models/user_model.dart';

class LoginResponseModel {
  final String token;
  final String refreshToken;
  final UserModel user;
  const LoginResponseModel({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['tokens']['token'],
      refreshToken: json['tokens']['refresh_token'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
