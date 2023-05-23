import 'package:flutter/material.dart';
import 'package:app_01/Screens/authenticate/register.dart';
import 'package:app_01/Screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toogleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignIn(toogleView): Register(toogleView);
  }
}
