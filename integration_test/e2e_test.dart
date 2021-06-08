import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app_runner.dart';
import 'google_account_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('google end-to-end test', () {
    late ApplicationRunner application;
    late GoogleAccountHelper accountHelper;

    setUpAll(() async {
      application = ApplicationRunner();
      accountHelper = GoogleAccountHelper();
    });

    testWidgets('google email read', (tester) async {
      await application.open(tester);

      await application.loginByGoogle();
      await accountHelper.isSignedIn();

      await application.markUnreadMailsAsReadInGoogle();
      await accountHelper.hasEmptyUnreadMails();
    });

    testWidgets('google email deletion', (tester) async {
      await application.open(tester);

      await application.loginByGoogle();
      await application.deleteAllUnreadMailsInGoogle();
    });
  });
}
