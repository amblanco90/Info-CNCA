import 'package:flutter/material.dart';

class User {

  final String userName;
  final String photoUrl;
  final String userEmail;
  User(this.userName,this.photoUrl,this.userEmail);

  User.fromMap(Map snapshot, String email):
  userEmail = email ?? '',
  photoUrl = snapshot["Imagen"],
  userName = snapshot["Nombre"];

  
  
}
