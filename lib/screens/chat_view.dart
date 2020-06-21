import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:threads_app/models/models.dart';
import 'package:dash_chat/dash_chat.dart';
import 'dart:async';

class ChatView extends StatefulWidget {
  final User user;
  final User otherUser;
  final String chatId;

  ChatView({
    this.user,
    this.otherUser,
    this.chatId,
  }) : assert(user != null, otherUser != null);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  ChatUser user, otherUser;

  @override
  void initState() {
    super.initState();
    user = ChatUser(
      name: widget.user.name,
      uid: widget.user.userId,
    );
    otherUser = ChatUser(
        name: widget.otherUser.name,
        uid: widget.otherUser.userId,
        containerColor: Colors.grey[300]);
  }

  void onSend(ChatMessage message) {
    final currentTime = DateTime.now().toString().trim().replaceFirst(' ', '|');
    print('Currentime: $currentTime');
    var documentReference = Firestore.instance.collection('chats').document(widget.chatId).collection('messages').document(currentTime);
    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(documentReference, {
        'message': message.text,
        'time': currentTime,
        'sender': message.user.name,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUser.name),
        backgroundColor: Colors.red[300],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('chats')
            .document(widget.chatId)
            .collection('messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          } else {
            List<DocumentSnapshot> documents = snapshot.data.documents;
            var messages = documents
                .map((document) => ChatMessage(
                      user: document['sender'] == user.name ? user : otherUser,
                      text: document['message'],
                      createdAt: DateTime.parse(
                        document['time'].replaceAll('|', ' '),
                      ),
                    ))
                .toList();
            return DashChat(
              key: _chatViewKey,
              inverted: false,
              onSend: onSend,
              sendOnEnter: true,
              textInputAction: TextInputAction.send,
              user: user,
              inputDecoration:
                  InputDecoration.collapsed(hintText: "Add message here..."),
              dateFormat: DateFormat('yyyy-MMM-dd'),
              timeFormat: DateFormat('HH:mm'),
              messages: messages,
              showUserAvatar: false,
              showAvatarForEveryMessage: false,
              scrollToBottom: false,
              onPressAvatar: (ChatUser user) {
                print("OnPressAvatar: ${user.name}");
              },
              onLongPressAvatar: (ChatUser user) {
                print("OnLongPressAvatar: ${user.name}");
              },
              inputMaxLines: 5,
              messageContainerPadding: EdgeInsets.only(left: 10.0, right: 5.0),
              alwaysShowSend: true,
              inputTextStyle: TextStyle(fontSize: 16.0),
              inputContainerStyle: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 0.0),
                color: Colors.white,
              ),
              messageContainerDecoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(12),
                ),
                color: Colors.red[300],
              ),
              inputToolbarMargin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              
              onLoadEarlier: () {
                print("laoding...");
              },
              shouldShowLoadEarlier: false,
              showTraillingBeforeSend: true,
            );
          }
        },
      ),
    );
  }
}
