import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import "package:googleapis_auth/auth_browser.dart" as gapis;
import 'package:http/http.dart' as http;

import '../services/mail_service.dart';

class UnreadGmailApi {
  gmail.GmailApi? _gmailApi;
  final _id = '415636126375-u93cn13vc6gsvoi44onip4fte6n12kqs.apps.googleusercontent.com';

  Future<gmail.GmailApi> _api() async {
    if (_gmailApi != null) {
      return _gmailApi!;
    }
    final scopes = <String>[gmail.GmailApi.mailGoogleComScope];
    final clientId = gapis.ClientId(_id, null);
    final flow = await gapis.createImplicitBrowserFlow(clientId, scopes);
    final credentials = await flow.obtainAccessCredentialsViaUserConsent();
    final client = gapis.authenticatedClient(http.Client(), credentials);
    _gmailApi = gmail.GmailApi(client);
    flow.close();

    return _gmailApi!;
  }

  Future<void> _batchModifyMailLabels(gmail.GmailApi api, List<String> mailIds,
      {List<String>? removeLabelIds, List<String>? addLabelIds}) async {
    Iterable<String> mailIterable = mailIds;
    final modifyRequest = gmail.BatchModifyMessagesRequest();

    modifyRequest.removeLabelIds = removeLabelIds;
    modifyRequest.addLabelIds = addLabelIds;
    while(mailIterable.isNotEmpty) {
      modifyRequest.ids = mailIterable.take(1000).toList();
      mailIterable = mailIterable.skip(1000);
      await api.users.messages.batchModify(modifyRequest, 'me');
    }
  }

  Future<List<String>> _unreadMailIds() async {
    Stream<String> _streamOfUnreadMailIds() async* {
      String? nextPageToken;
      final api = await _api();
      do {
        final response = await api
            .users
            .messages
            .list(
                'me',
                labelIds: <String>['UNREAD'],
                maxResults: 500,
                pageToken: nextPageToken
            );
        final messages = response.messages ?? [];
        nextPageToken = response.nextPageToken;
        for (var message in messages) {
          final id = message.id;
          if (id != null) yield id;
        }
      } while(nextPageToken != null);
    }

    return _streamOfUnreadMailIds().toList();
  }

  Future<int> readLength() async {
    final list = await _unreadMailIds();

    return list.length;
  }

  Future<void> readAll() async {
    final api = await _api();
    final ids = await _unreadMailIds();
    const removeLabelIds = <String>['UNREAD'];

    return _batchModifyMailLabels(api, ids, removeLabelIds: removeLabelIds);
  }
  
  Future<void> deleteAll() async {
    final api = await _api();
    final ids = await _unreadMailIds();
    const addLabelIds = <String>['TRASH'];

    return _batchModifyMailLabels(api, ids, addLabelIds: addLabelIds);
  }
}

class GoogleMailService implements MailService {
  UnreadGmailApi? _api;
  final _googleService = GoogleSignIn();

  @override
  Future<bool> login() async {
    const scopes = <String>[gmail.GmailApi.mailGoogleComScope];
    try {
      final user = await _googleService.signInSilently();
      if (user == null) {
        await _googleService.signIn();
      }
    } on Exception catch(e) {
      print(e);
    }
    final signedIn = await _googleService.isSignedIn()
        && await _googleService.requestScopes(scopes);
    if (signedIn) {
      _api = UnreadGmailApi();
    }

    return signedIn;
  }

  @override
  Future<void> deleteAllUnreadMails() async {
    return _api?.deleteAll();
  }

  @override
  Future<void> readAllUnreadMails() async {
    return _api?.readAll();
  }

  @override
  Future<int> unreadMailCount() async {
    return _api?.readLength() ?? Future.value(0);
  }
}