import 'package:flutter/material.dart';
import 'dart:math';

class AddFriendScreen extends StatelessWidget {
  final friendList = [
    {
      'name': 'Rahul',
      'interests': ['Technology', 'Education'],
      'friends': 16,
    },
    {
      'name': 'Aman',
      'interests': ['Sports', 'Politics', 'Games'],
      'friends': 34,
    },
    {
      'name': 'Xanthis',
      'interests': ['Games', 'Education'],
      'friends': 25,
    },
    {
      'name': 'Rishav',
      'interests': ['Cricket', 'Programming'],
      'friends': 19,
    },
    {
      'name': 'Yakub',
      'interests': ['Football', 'Hockey', 'Education'],
      'friends': 48,
    },
    {
      'name': 'Ayush',
      'interests': ['Video Games', 'Education'],
      'friends': 81,
    },
    {
      'name': 'Yash',
      'interests': ['Politics', 'Sports'],
      'friends': 63,
    },
    {
      'name': 'Gourav',
      'interests': ['Games', 'Politics', 'Sports'],
      'friends': 55,
    },
    {
      'name': 'Amir',
      'interests': ['Dance', 'Music', 'Technology'],
      'friends': 41,
    },
    {
      'name': 'Gourav',
      'interests': ['Games', 'Politics', 'Sports'],
      'friends': 55,
    },
    {
      'name': 'Amir',
      'interests': ['Dance', 'Music', 'Technology'],
      'friends': 41,
    },
    {
      'name': 'Gourav',
      'interests': ['Games', 'Politics', 'Sports'],
      'friends': 55,
    },
    {
      'name': 'Amir',
      'interests': ['Dance', 'Music', 'Technology'],
      'friends': 41,
    },
    {
      'name': 'Gourav',
      'interests': ['Games', 'Politics', 'Sports'],
      'friends': 55,
    },
    {
      'name': 'Amir',
      'interests': ['Dance', 'Music', 'Technology'],
      'friends': 41,
    },
  ];
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: mediaQuery.size.height * 0.045),
            height: mediaQuery.size.height,
            width: mediaQuery.size.width,
            alignment: Alignment.topCenter,
            color: Colors.red[300],
            child: Text(
              'Add Friend',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: mediaQuery.size.height * 0.03,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            top: mediaQuery.size.height * 0.1,
            child: Container(
              height: mediaQuery.size.height * 0.9,
              width: mediaQuery.size.width,
              padding: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                color: Colors.white,
              ),
              child: ListView(
                children: friendList.map(_buildTile).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(Map item) {
    final double avatarSize = 50;
    final List<String> interests = item['interests'];
    return ExpansionTile(
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(avatarSize / 2),
                image: DecorationImage(
                  image: AssetImage('assets/${Random().nextInt(9) + 1}.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(item['name']),
            Row(
              children: <Widget>[
                Icon(
                  Icons.people,
                  color: Colors.red[300],
                ),
                SizedBox(width: 5),
                Text(
                  item['friends'].toString(),
                  style: TextStyle(color: Colors.red[300]),
                ),
              ],
            ),
          ],
        ),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: interests.map((interest) {
                  return Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Text(interest),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(width: 20),
            Row(
              children: <Widget>[
                Icon(
                  Icons.person_add,
                  color: Colors.red[300],
                ),
                SizedBox(width: 5),
                Text(
                  'Add Friend',
                  style: TextStyle(color: Colors.red[300]),
                ),
                SizedBox(width: 10),
              ],
            )
          ],
        ),
      ],
    );
  }
}
