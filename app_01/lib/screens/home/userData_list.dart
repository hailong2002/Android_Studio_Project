import 'package:app_01/models/user_info.dart';
import 'package:app_01/screens/home/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UserDataList extends StatefulWidget {
  const UserDataList({Key? key}) : super(key: key);

  @override
  State<UserDataList> createState() => _UserDataListState();
}

class _UserDataListState extends State<UserDataList> {
  @override
  Widget build(BuildContext context) {
    final userInfo =  Provider.of<List<UserInfo>>(context) ?? [];


    return ListView.builder(
        itemCount: userInfo.length,
        itemBuilder: (context, index){
          return UserTile(userInfo[index]);
        },
    );
  }
}
