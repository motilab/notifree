import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final GestureTapCallback _loginByGoogle;

  const LoginScreen({
    Key? key,
    required GestureTapCallback loginByGoogle
  }) : _loginByGoogle = loginByGoogle, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            const SizedBox(
              height: 31,
            ),
            const Text('notifree',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            TextButton(
              onPressed: _loginByGoogle,
              // child: Text('Google Login'),
              child: Image.asset('assets/images/google_login_button.png',
                width: 210,
                height: 50,
              ),
            ),
            const SizedBox(
              height: 52,
            ),
            const Text('motiLab',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
