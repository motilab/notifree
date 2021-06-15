import 'package:flutter/material.dart';
import './screens/login_screen.dart';
import './services/mail_service.dart';

class Application extends StatelessWidget {
  final MailService _googleMailService;

  const Application({
    Key? key,
    required MailService googleMailService
  }) : _googleMailService = googleMailService,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifree',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginScreen(
          loginByGoogle: () async {
            final isSignedIn = await _googleMailService.login();
            if (isSignedIn) {
              Navigator.pushNamed(context, '/google');
            }
          },
        ),
        '/google': (context) => Container(
          child: Text('google'),
        )
      },
    );
  }
}