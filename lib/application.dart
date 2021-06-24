import 'package:flutter/material.dart';
import './screens/login_screen.dart';
import './screens/mail_clean_screen.dart';
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
      title: 'notifree',
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginScreen(
          loginByGoogle: Feedback.wrapForTap(() async {
            final isSignedIn = await _googleMailService.login();
            if (isSignedIn) {
              Navigator.pushNamed(context, '/google');
            }
          }, context) ?? () {}
        ),
        '/google': (context) => FutureBuilder<int>(
          future: _googleMailService.unreadMailCount(),
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              print(snapshot.error);
            }
            if(snapshot.hasData) {
              return MailCleanScreen(
                unreadMails: snapshot.data!,
                readAllUnreadMails: () async {
                  await _googleMailService.readAllUnreadMails();
                },
                deleteAllUnreadMails: () async {
                  await _googleMailService.deleteAllUnreadMails();
                }
              );
            }
            else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
        )
      },
    );
  }
}