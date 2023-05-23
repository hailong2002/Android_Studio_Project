import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_01/Services/auth.dart';
import 'package:app_01/shared/constants.dart';
import 'package:app_01/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title:const Text('Sign in'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              label: const Text('Register', style: TextStyle(color: Colors.white),),
              icon: const Icon(Icons.edit_document, color: Colors.white,),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 15.0, width: 50.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Enter email !' : null,
                onChanged: (value){
                  setState(()=> email =value);
                },
              ),
              SizedBox(height: 15.0, width: 50.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (value) => value!.length < 6 ?
                'Password must be at least 6 character !' : null,
                obscureText: true,
                onChanged: (value){
                  setState(()=> password =value);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    //validate
                    if (_formKey.currentState!.validate()){
                      setState(()=> loading = true);
                      dynamic result = await _auth.signInWithEmail(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Could not sign in !';
                          loading = false;
                        });
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.redAccent,),
                  ),
                  child:const Text('Sign in', style: TextStyle(fontSize: 20.0),),
                ),
              ),
              SizedBox(height: 12.0,),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 20.0),
              )

            ],
          ),
        ),

      ),

    );
  }
}
