import 'package:client/features/auth/domain/repositories/auth_repository.dart';
import 'package:client/features/register/presentations/bloc/register_bloc.dart';
import 'package:client/features/register/presentations/widgtes/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (_) =>
              RegisterBloc(authRepository: context.read<AuthRepository>()),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
