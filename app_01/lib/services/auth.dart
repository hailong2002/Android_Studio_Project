import 'package:app_01/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_01/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user obj based on FirebaseUser
  MyUser? _userFromFirebaseUser(User user) {
    return user != null ? MyUser(user.uid) : null;
  }

  //auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  //Sign in annonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }
    catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Sign in with email
  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null)
        return _userFromFirebaseUser(user!);
      return null;
    }
    catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Register with email
  Future registerWithEmail(String email, String password) async{
    try{
      UserCredential result = await _auth.
      createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if (user != null) {
        try {
          await DatabaseService(user.uid).updateUserData('ABCDEF', 'Hanoi', 100);
        } catch (e) {
          print('Error setting user data: $e');
        }
      }

      return _userFromFirebaseUser(user!);
    }
    catch(error){
      print(error.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async{
    try {
        return await _auth.signOut();
    }
    catch(error){
        print(error.toString());
    }
  }

}