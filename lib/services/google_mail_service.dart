
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

import '../services/mail_service.dart';
import '../util/nullable_element_iterable.dart';

class GoogleMailService implements MailService {
  final _googleService = GoogleSignIn();

  Future<gmail.GmailApi> _getGmailApi() async {
    final client = (await _googleService.authenticatedClient())!;
    return gmail.GmailApi(client);
  }

  Future<List<String>> _getUnreadMailIds(gmail.GmailApi api) async {
    final unreadMails = await api
        .users
        .messages
        .list('me', labelIds: <String>['UNREAD']);
    final unreadMailIds = unreadMails
        .messages
        ?.map((e) => e.id)
        .whereNonNull()
        .toList() ?? <String>[];
    return unreadMailIds;
  }

  @override
  Future<void> deleteAllUnreadMails() async {
    final api = await _getGmailApi();
    final unreadMailIds = await _getUnreadMailIds(api);
    final modifyRequest = gmail.BatchModifyMessagesRequest();

    modifyRequest.ids = unreadMailIds;
    modifyRequest.removeLabelIds = <String>['UNREAD'];
    modifyRequest.addLabelIds = <String>['TRASH'];
    await api.users.messages.batchModify(modifyRequest, 'me');
  }

  @override
  Future<bool> login() async {
    try {
      await _googleService.signIn();
    }
    on Exception catch(e) {
      print(e);
    }

    return await _googleService.isSignedIn();
  }

  @override
  Future<void> readAllUnreadMails() async {
    final api = await _getGmailApi();
    final unreadMailIds = await _getUnreadMailIds(api);
    final modifyRequest = gmail.BatchModifyMessagesRequest();

    modifyRequest.ids = unreadMailIds;
    modifyRequest.removeLabelIds = <String>['UNREAD'];
    await api.users.messages.batchModify(modifyRequest, 'me');
  }

  @override
  Future<int> unreadMailCount() {
    // TODO: implement unreadMailCount
    throw UnimplementedError();
  }
}