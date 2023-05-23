import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_01/Screens/wrapper.dart';
import 'package:app_01/Services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_01/models/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, error) {
        print('Error');
      },
      child: const MaterialApp(
        home: Wrapper(),
      ),

    );
  }
}
