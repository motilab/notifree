import 'package:flutter/material.dart';

class MailCleanScreen extends StatelessWidget {
  final int _unreadMails;
  final void Function() _readAllUnreadMails;
  final void Function() _deleteAllUnreadMails;

  const MailCleanScreen({
    Key? key,
    required int unreadMails,
    required void Function() readAllUnreadMails,
    required void Function() deleteAllUnreadMails
  }) : _unreadMails = unreadMails,
        _readAllUnreadMails = readAllUnreadMails,
        _deleteAllUnreadMails = deleteAllUnreadMails,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('$_unreadMails'),
            TextButton(onPressed: _readAllUnreadMails, child: Text('읽기')),
            TextButton(onPressed: _deleteAllUnreadMails, child: Text('삭제'))
          ],
        )
      ),
    );
  }
}
