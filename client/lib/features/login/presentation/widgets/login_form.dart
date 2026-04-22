import 'package:client/core/styles/colors.dart';
import 'package:client/core/styles/styles.dart';
import 'package:client/features/login/presentation/bloc/login_bloc.dart';
import 'package:client/features/login/presentation/widgets/input_email.dart';
import 'package:client/features/login/presentation/widgets/input_password.dart';
import 'package:client/features/login/presentation/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    InputEmail(),
                    InputPassword(),
                    TextButton(
                      style: TextButton.styleFrom(
                        alignment: AlignmentGeometry.centerEnd,
                        overlayColor: MyColors.card,
                      ),
                      onPressed: () {},
                      child: Text('Forgot password?'),
                    ),
                    LoginButton(),
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
