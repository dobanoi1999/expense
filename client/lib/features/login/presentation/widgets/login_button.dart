import 'package:client/core/styles/colors.dart';
import 'package:client/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isProcess = context.select(
      (LoginBloc value) => value.state.status.isInProgress,
    );
    return TextButton(
      onPressed: () {
        if (!isProcess) {
          context.read<LoginBloc>().add(const LoginSubmitted());
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: isProcess
            ? MyColors.primary.withValues(alpha: 0.3)
            : MyColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        minimumSize: Size(200, 56),
      ),
      child: isProcess
          ? const CircularProgressIndicator()
          : Text(
              'Sign in',
              style: TextStyle(color: MyColors.primaryForeground),
            ),
    );
  }
}
