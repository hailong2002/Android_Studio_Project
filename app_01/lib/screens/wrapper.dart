import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_01/models/user.dart';
import 'package:app_01/screens/authenticate/authenticate.dart';
import 'package:app_01/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if(user == null)
      return Authenticate();
    return Home();
  }
}
