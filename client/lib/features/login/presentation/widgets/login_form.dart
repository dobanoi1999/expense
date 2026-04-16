import 'package:client/features/login/presentation/bloc/login_bloc.dart';
import 'package:client/features/login/presentation/widgets/input_email.dart';
import 'package:client/features/login/presentation/widgets/input_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStage>(
      listener: (context, state) {
        // print(state.status);
      },
      child: Align(
        alignment: Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputEmail(),
            const Padding(padding: EdgeInsets.all(12)),
            InputPassword(),
            const Padding(padding: EdgeInsets.all(12)),
          ],
        ),
      ),
    );
  }
}
