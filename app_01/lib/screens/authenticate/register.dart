import 'package:flutter/material.dart';
import 'package:app_01/services/auth.dart';
import 'package:app_01/shared/constants.dart';
import 'package:app_01/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register(this.toggleView);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            title: const Text('Register account'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: const Text('Sign in', style: TextStyle(color: Colors.white),)
              )
            ],
          ),
          body: Container(
            padding:  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (value) => value!.isEmpty ? 'Enter email !': null,
                    onChanged: (value){
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (value) => value!.length < 6 ?
                      'Password must have at least 6 character !': null,
                    obscureText: true,
                    onChanged: (value){
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        //validate
                        if(_formKey.currentState!.validate()){
                          setState(() => loading =true);
                          dynamic result = await _auth.registerWithEmail(email, password);
                          if(result == null){
                            setState(() {
                              error = 'Email is not valid';
                              loading = false;
                            });
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.cyan),
                      ),
                      child: const Text('Register', style: TextStyle(fontSize: 20.0)),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    error,
                    style:const TextStyle(color: Colors.red, fontSize: 15.0),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
