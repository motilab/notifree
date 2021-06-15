abstract class MailService {
  Future<bool> login();
  Future<void> readAllUnreadMails();
  Future<void> deleteAllUnreadMails();
  Future<int> unreadMailCount();
}
