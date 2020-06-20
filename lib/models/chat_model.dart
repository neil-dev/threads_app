import 'package:meta/meta.dart';

class Chat {
  final String user1;
  final String user2;
  final List<Map<String, dynamic>> messages;

  Chat({
    @required this.user1,
    @required this.user2,
    @required this.messages,
  });
}
