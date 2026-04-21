import 'package:client/core/styles/colors.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: MyColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        minimumSize: Size(200, 56),
      ),
      child: Text(
        'Sign in',
        style: TextStyle(color: MyColors.primaryForeground),
      ),
    );
  }
}
