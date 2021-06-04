import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

class ApplicationRunner {
  late FlutterDriver _driver;

  Future<void> connect() async {
    _driver = await FlutterDriver.connect();
  }

  Future<void> close() {
    return _driver.close();
  }

  void loginByGoogle() {
    // TODO("Unimplemented")
  }

  void markUnreadMailsAsReadInGoogle() {
    // TODO("Unimplemented")
  }

  void deleteAllUnreadMailsInGoogle() {
    // TODO("Unimplemented")
  }
}