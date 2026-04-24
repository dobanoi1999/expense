import 'package:client/core/fomz/confirm_password.dart';
import 'package:client/core/fomz/email.dart';
import 'package:client/core/fomz/name.dart';
import 'package:client/core/fomz/password.dart';
import 'package:client/core/services/snackbar_service.dart';
import 'package:client/core/styles/colors.dart';
import 'package:client/core/styles/styles.dart';
import 'package:client/core/widgets/input_widget.dart';
import 'package:client/features/login/presentation/pages/login_page.dart';
import 'package:client/features/register/presentations/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          SnackBarService.show(
            message: 'Register successfully',
            type: SnackBarType.success,
          );
          Navigator.of(context).push(LoginPage.route());
        }
      },
      child: Align(
        alignment: Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Create an Account', style: kRegisterTitleLight),
            const Padding(padding: EdgeInsets.all(5)),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text(
                'Start your journey to financial freedom and effective spending management.',
                style: kRegisterDescLight,
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
                    _InputFullName(),
                    _InputEmail(),
                    _InputPassword(),
                    _InputConfirmPassword(),
                    _LoginButton(),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(12)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(LoginPage.route());
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Already have an account? ",
                      style: kLoginDescLight,
                    ),
                    TextSpan(text: 'Sign in now', style: kTextRegisterLight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InputFullName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, Name>(
      selector: (state) => state.fullName,
      builder: (_, fullName) {
        return InputWidget(
          label: 'Full name',
          key: const Key('formRegister_fullNameInput'),
          errText: fullName.displayError?.text(),
          onChanged: (value) {
            context.read<RegisterBloc>().add(RegisterFullNameChanged(value));
          },
        );
      },
    );
  }
}

class _InputEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, Email>(
      selector: (state) => state.email,
      builder: (_, email) {
        return InputWidget(
          label: 'Email',
          key: const Key('formRegister_emailInput'),
          errText: email.displayError?.text(),
          onChanged: (value) {
            context.read<RegisterBloc>().add(RegisterEmailChanged(value));
          },
        );
      },
    );
  }
}

class _InputPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, Password>(
      selector: (state) => state.password,
      builder: (_, password) {
        return InputWidget(
          label: 'Password',
          key: const Key('formRegister_passwordInput'),
          errText: password.displayError?.text(),
          obscureText: true,
          onChanged: (value) {
            context.read<RegisterBloc>().add(RegisterPasswordChanged(value));
          },
        );
      },
    );
  }
}

class _InputConfirmPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      RegisterBloc,
      RegisterState,
      ConfirmPasswordValidationError?
    >(
      selector: (state) => state.confirmPassword.displayError,
      builder: (_, displayError) {
        return InputWidget(
          label: 'Confirm password',
          key: const Key('formLogin_confirmPasswordInput'),
          errText: displayError?.text(),
          obscureText: true,
          onChanged: (value) {
            context.read<RegisterBloc>().add(
              RegisterConfirmPasswordChanged(value),
            );
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterBloc, RegisterState, bool>(
      selector: (state) => state.status.isInProgress,
      builder: (context, isProcess) {
        return TextButton(
          onPressed: () {
            if (!isProcess) {
              context.read<RegisterBloc>().add(const RegisterSubmitted());
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
                  'Register',
                  style: TextStyle(color: MyColors.primaryForeground),
                ),
        );
      },
    );
  }
}
