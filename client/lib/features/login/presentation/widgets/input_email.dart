import 'package:client/core/styles/styles.dart';
import 'package:client/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputEmail extends StatelessWidget {
  const InputEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final displayErr = context.select(
      (LoginBloc bloc) => bloc.state.email.displayError,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text('Email', style: kInputLabelLight),
        ),
        const Padding(padding: EdgeInsets.all(2)),
        TextField(
          key: const Key('loginForm_inputEmail_textField'),
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginEmailChanged(value));
          },
          obscureText: false,
          decoration: InputDecoration(
            errorText: displayErr != null ? 'Email is valid' : null,
          ),
        ),
      ],
    );
  }
}
