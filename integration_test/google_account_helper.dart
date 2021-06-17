import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAccountHelper {
  late GoogleSignIn _googleSignIn;

  GoogleAccountHelper() {
    _googleSignIn = GoogleSignIn();
  }

  Future<void> isSignedIn() async {
    final isSignedIn = await _googleSignIn.isSignedIn();

    expect(isSignedIn, isTrue, reason: 'User is not signed in google.');
  }

  Future<void> hasEmptyUnreadMails() async {
    await isSignedIn();

    final httpClient = (await _googleSignIn.authenticatedClient())!;
    final gmailApi = GmailApi(httpClient);
    final unreadMails = await gmailApi.users.messages.list('me', labelIds: <String>['UNREAD']);
    final length = unreadMails.messages?.length ?? 0;

    expect(length, isZero);
  }
}