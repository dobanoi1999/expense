import 'package:client/core/fomz/password.dart';
import 'package:client/core/styles/styles.dart';
import 'package:client/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final displayErr = context.select(
      (LoginBloc bloc) => bloc.state.password.displayError,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Password', style: kInputLabelLight),
        ),
        const Padding(padding: EdgeInsets.all(2)),
        TextField(
          key: const Key('loginForm_inputPassword_textField'),
          onChanged: (password) {
            context.read<LoginBloc>().add(LoginPasswordChanged(password));
          },
          obscureText: true,
          decoration: InputDecoration(errorText: displayErr?.text()),
        ),
      ],
    );
  }
}
