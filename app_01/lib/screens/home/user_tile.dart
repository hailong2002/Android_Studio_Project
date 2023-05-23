import 'package:flutter/material.dart';
import 'package:app_01/models/user_info.dart';

class UserTile extends StatelessWidget {
  final UserInfo info;

  UserTile(this.info);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top:10.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(10, 0, 10,0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.cyan[info.age],
              backgroundImage: AssetImage('assets/pixel.png'),
            ),
            title: Text(info.name),
            subtitle: Text('Address: ${info.address}'),
          ),
        ),
    );
  }
}
