import 'package:test/test.dart';

import 'app_runner.dart';

void main() {
  group('end-to-end tests', () {
    late ApplicationRunner application;

    setUpAll(() async {
      application = new ApplicationRunner();
      await application.connect();
    });

    tearDownAll(() async {
      await application.close();
    });

    test('google email read', () {
      application.loginByGoogle();
      application.markUnreadMailsAsReadInGoogle();
    });
    
    test('google email deletion', () {
      application.loginByGoogle();
      application.deleteAllUnreadMailsInGoogle();
    });
  });
}