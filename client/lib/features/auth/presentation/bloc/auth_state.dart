part of 'auth_bloc.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? err;
  const AuthState({required this.status, this.user, this.err});

  AuthState copyWith({AuthStatus? status, User? user, String? err}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      err: err ?? this.err,
    );
  }

  @override
  List<Object?> get props => [status, user, err];
}
