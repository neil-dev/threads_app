import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:threads_app/models/models.dart';
import 'package:threads_app/screens/screens.dart';

class ChatRepository {
  Future<User> getUserByEmail(String email) async {
    final user = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    List<User> users = user.documents
        .map((DocumentSnapshot document) => User(
              email: document['email'],
              name: document['name'],
              nickname: document['nickname'],
              avatar: document['avatar'],
              userId: document.documentID,
            ))
        .toList();
    print(users);
    try {
      print(users[0].name);
      return users[0];
    } catch (e) {
      print('No user matches with email $email');
      return null;
    }
  }

  Future<User> getUserById(String userId) async {
    final user =
        await Firestore.instance.collection('users').document(userId).get();
    return User(
      email: user['email'],
      name: user['name'],
      nickname: user['nickname'],
      avatar: user['avatar'],
      userId: userId,
    );
  }

  List<Widget> getChat(
      User user, List<DocumentSnapshot> documents, BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final messages = [
      'Hi',
      'Hello',
      'I am rock',
      'What is your favorite game?',
      'Wanna play?',
      'You look beautiful',
      'Girl\'s on fire',
      'Gotta go',
      'see you later',
      'Bye',
    ];
    documents = documents.where((doc) => _isPresent(doc['users'], user.userId)).toList();
    return documents.map((document) {
      final otherUserIndex = user.name == document['users'][0]['name'] ? 1 : 0;
      final otherUser = User(
        email: document['users'][otherUserIndex]['email'] ?? '',
        name: document['users'][otherUserIndex]['name'] ?? '',
        nickname: document['users'][otherUserIndex]['nickname'] ?? '',
        userId: document['users'][otherUserIndex]['userId'] ?? '',
      );

      final height = mediaQuery.size.height * 0.1;
      return GestureDetector(
        child: Container(
          width: mediaQuery.size.width,
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(),
          height: height,
          child: Row(
            children: <Widget>[
              SizedBox(width: 15),
              Container(
              width: height / 2 + 10,
              height: height / 2 + 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((height / 2 + 10) / 2),
                image: DecorationImage(
                  image: AssetImage('assets/${Random().nextInt(9) + 1}.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
              SizedBox(width: 25),
              Container(
                width: mediaQuery.size.width - 2 * height -50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300],
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      otherUser.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      messages[Random().nextInt(messages.length)],
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatView(
              user: user,
              otherUser: otherUser,
              chatId: document.documentID,
            ),
          ),
        ),
      );
    }).toList();
  }

  bool _isPresent(List<dynamic> list, String id) {
    
    for (int i = 0; i < list.length; i++) {
      print(list[i].toString());
      if (list[i]['userId'].toString().trim() == id) {
        print('true');
        return true;
      }
    }
    return false;
  }

  Stream<QuerySnapshot> getMessages(String chatId) {
    return Firestore.instance
        .collection('chats')
        .document(chatId)
        .collection('messages')
        .snapshots();
  }
}
