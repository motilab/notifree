import 'package:flutter_test/flutter_test.dart';
import 'package:notifree/main.dart' as app;

class ApplicationRunner {
  late WidgetTester _tester;

  Future<void> open(WidgetTester tester) async {
    _tester = tester;

    app.main();
    await _tester.pumpAndSettle();
  }

  Future<void> loginByGoogle() async {
    // TODO("Unimplemented")
  }

  Future<void> markUnreadMailsAsReadInGoogle() async {
    // TODO("Unimplemented")
  }

  Future<void> deleteAllUnreadMailsInGoogle() async {
    // TODO("Unimplemented")
  }
}