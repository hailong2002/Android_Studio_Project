import 'package:app_01/models/user_info.dart';
import 'package:app_01/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:app_01/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:app_01/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_01/screens/home/userData_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding:const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: SettingForm(),
        );
      });
    }

    return StreamProvider<List<UserInfo>?>.value(
      value: DatabaseService(
          'zYJyUzgZANcTqVaKhWfPZGTtctR2').userInfo,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.purple[300],
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Carpool', style: TextStyle(color: Colors.white),),
          actions: [
            TextButton.icon(
                onPressed: () async{
                  await _auth.signOut();
                },
                label: const Text('Sign out', style: TextStyle(color: Colors.white),),
                icon:const Icon(Icons.logout,color: Colors.white,),
            ),
            TextButton.icon(
                onPressed: ()=>_showSettingPanel(),
                icon: const Icon(Icons.settings, color: Colors.white,),
                label: const Text('Settings', style: TextStyle(color: Colors.white),))
          ],
        ),
        body: Container(
          width: 500,  // Adjust the width as desired
          height: 500,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/girl.png'),
                fit: BoxFit.cover,
              )
            ),

            child: UserDataList(

          ),
        ),
      ),
    );
  }
}
