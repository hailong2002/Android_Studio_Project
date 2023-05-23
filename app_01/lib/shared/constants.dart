import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
  hintText: 'Password',
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.white, width: 3.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.greenAccent, width: 3.0),
  ),
);