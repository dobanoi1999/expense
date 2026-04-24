import 'package:client/core/fomz/email.dart';
import 'package:client/core/fomz/password.dart';
import 'package:client/core/styles/colors.dart';
import 'package:client/core/styles/styles.dart';
import 'package:client/core/widgets/input_widget.dart';
import 'package:client/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStage>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        print(state.status);
      },
      child: Align(
        alignment: Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome Back!', style: kLoginTitleLight),
            const Padding(padding: EdgeInsets.all(6)),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: Text(
                'Sign in to continue your financial management journey with 6 Jars system.',
                style: kLoginDescLight,
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            Card(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 24,
                  horizontal: 12,
                ),
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _InputEmail(),
                    _InputLogin(),
                    TextButton(
                      style: TextButton.styleFrom(
                        alignment: AlignmentGeometry.centerEnd,
                        overlayColor: MyColors.card,
                      ),
                      onPressed: () {},
                      child: Text('Forgot password?'),
                    ),
                    _LoginButton(),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(12)),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Don't have an account? ",
                    style: kLoginDescLight,
                  ),
                  TextSpan(text: 'Register now', style: kTextRegisterLight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginStage, Email>(
      selector: (state) => state.email,
      builder: (_, email) {
        return InputWidget(
          label: 'Email',
          key: const Key('formLogin_emailInput'),
          errText: email.displayError?.text(),
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginEmailChanged(value));
          },
        );
      },
    );
  }
}

class _InputLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginStage, Password>(
      selector: (state) => state.password,
      builder: (_, password) {
        return InputWidget(
          label: 'Password',
          key: const Key('formLogin_passwordInput'),
          errText: password.displayError?.text(),
          obscureText: true,
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginPasswordChanged(value));
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginStage, bool>(
      selector: (state) => state.status.isInProgress,
      builder: (context, isProcess) {
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            minimumSize: Size(200, 56),
          ),
          child: isProcess
              ? const CircularProgressIndicator()
              : Text(
                  'Sign in',
                  style: TextStyle(color: MyColors.primaryForeground),
                ),
        );
      },
    );
  }
}
