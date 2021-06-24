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
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            const SizedBox(
              height: 31,
            ),
            const Text('notifree',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 53,
            ),
            Text('읽지 않은 메일이 $_unreadMails개 있습니다.',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 44,
            ),
            TextButton(
              onPressed: _readAllUnreadMails,
              child: Container(
                width: 246,
                height: 43,
                decoration: const BoxDecoration(
                  color: Color(0xFF40B7EB),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: const Center(
                  child: Text('모두 읽음 처리',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            TextButton(
              onPressed: _deleteAllUnreadMails,
              child: Container(
                width: 246,
                height: 43,
                decoration: const BoxDecoration(
                  color: Color(0xFFEB4040),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: const Center(
                  child: Text('모두 삭제',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 63,
            ),
            const Text('motiLab',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
