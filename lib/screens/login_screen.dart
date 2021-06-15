import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final void Function() loginByGoogle;

  const LoginScreen({
    Key? key,
    required this.loginByGoogle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TextButton(
          onPressed: loginByGoogle,
          child: Text('Google Login')
        ),
      ),
    );
  }
}
