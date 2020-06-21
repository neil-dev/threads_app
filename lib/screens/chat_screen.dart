import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:threads_app/chat_repository.dart';
import 'package:threads_app/models/models.dart';
import 'package:threads_app/screens/screens.dart';

class ChatScreen extends StatefulWidget {
  final User currentUser;

  ChatScreen(this.currentUser);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final email = 'snow@gmail.com';
   User currentUser;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // currentUser =  widget.currentUser;
    print('CurrentUser $currentUser');
  }

  void getCurrentUser() async {
    final user = await ChatRepository().getUserByEmail(email);
    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    if (currentUser == null) {
      return Scaffold(body: CircularProgressIndicator());
    } else {
      print('userId: ${currentUser.userId}');
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: mediaQuery.size.height * 0.08,
              ),
              height: mediaQuery.size.height,
              width: mediaQuery.size.width,
              color: Colors.red[300],
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: mediaQuery.size.width * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.menu,
                      color: Colors.red[300],
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 40,
                    width: mediaQuery.size.width * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              controller: _textController,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.red[300]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.red[300],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddFriendScreen())),
                    child: Container(
                      height: 40,
                      width: mediaQuery.size.width * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Icon(
                        Icons.person_add,
                        color: Colors.red[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('chats').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Oops! Something went wrong!'),
                  );
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.red[300],),
                    );
                  default:
                    final chats = ChatRepository()
                        .getChat(currentUser, snapshot.data.documents, context);
                    return Positioned(
                      top: mediaQuery.size.height * 0.2,
                      child: Container(
                        height: mediaQuery.size.height * 0.8,
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          children: chats,
                        ),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      );
    }
  }
}

class ChatList extends StatelessWidget {
  const ChatList({
    Key key,
    @required this.chats,
  }) : super(key: key);

  final List<Widget> chats;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, i) {
          return chats[i];
        });
  }
}
