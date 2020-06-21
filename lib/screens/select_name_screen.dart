import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threads_app/models/models.dart';

import 'package:threads_app/screens/screens.dart';

class SelectNameScreen extends StatefulWidget {
  final String email;

  SelectNameScreen(this.email);
  @override
  _SelectNameScreenState createState() => _SelectNameScreenState();
}

class _SelectNameScreenState extends State<SelectNameScreen> {
  final TextEditingController _controller = TextEditingController();
  String name = '';
  final imgUrl = 'assets/${Random().nextInt(9) + 1}.png';

  final namechoices = [
    'wyzard',
    'Caffeinated_Potato',
    'moitbytes',
    'theWarChild',
    'deadshot',
    'xanthis',
    'DeadThunder',
    'Chocobar',
    'SoulSubho',
    'TxJoker',
    'Aeros',
    'Asentrix',
    'snax',
    'Ez boy',
    'catz',
    'For3xGam4',
    'TeMpo',
    'cloath',
    'PsyDanger',
    'Slocky',
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: mediaQuery.size.height,
            width: mediaQuery.size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: mediaQuery.size.height * 0.2),
                  Container(
                    height: mediaQuery.size.width * 0.6,
                    width: mediaQuery.size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(mediaQuery.size.width * 0.3),
                      border: Border.all(
                        width: 10,
                        color: Colors.purple,
                      ),
                      image: DecorationImage(
                        image: AssetImage(imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Choose a Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: mediaQuery.size.width * 0.7,
                        height: 40,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1),
                        ),
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'John',
                          ),
                          onChanged: (text) {
                            setState(() {
                              name = text;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          _controller.text =
                              namechoices[Random().nextInt(namechoices.length)];
                          setState(() {
                            name = _controller.text;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  RaisedButton(
                    disabledColor: Colors.grey,
                    onPressed: name == ''
                        ? null
                        : () {
                            final doc_ref = Firestore.instance
                                .collection('users')
                                .document();
                            doc_ref
                              ..setData({
                                'name': name,
                                'nickname': name,
                                'email': widget.email,
                              });
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  User(
                                    name: name,
                                    nickname: name,
                                    email: widget.email,
                                    userId: doc_ref.documentID,
                                  ),
                                ),
                              ),
                            );
                          },
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.red[300],
                    child: Text(
                      'PROCEED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: ClipPath(
              clipper: WaveClipper1(),
              child: RedBox(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper2(),
              child: RedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    path.lineTo(size.width, 0);

    path.close();
    return path;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, size.height);

    path.lineTo(size.width, 0);

    path.lineTo(0, size.height);

    path.close();
    return path;
  }
}

class RedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.3,
      width: mediaQuery.size.width * 0.3,
      decoration: BoxDecoration(
        color: Colors.red[300],
      ),
    );
  }
}
