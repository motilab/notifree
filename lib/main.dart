import 'package:flutter/material.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import './application.dart';
import './services/google_mail_service.dart';

void main() async {
  final googleMailService = GoogleMailService();

  await GoogleSignInPlugin().init();

  final app = Application(
    googleMailService: googleMailService,
  );
  runApp(app);
}
