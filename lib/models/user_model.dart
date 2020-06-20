import 'package:meta/meta.dart';

class User {
  final String userId;
  final String name;
  final String nickname;
  final String avatar;
  final String email;

  User({
    @required this.name,
    @required this.nickname,
    @required this.userId,
    this.avatar,
    @required this.email,
  });
}
