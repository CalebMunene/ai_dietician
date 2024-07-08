import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class ProfilePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  final UserModel user;

  ProfilePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Column(
        children: <Widget>[
          Text('Name: ${user.name}'),
          Text('Email: ${user.email}'),
          Text('Age: ${user.age}'),
          ElevatedButton(
            child: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
    );
  }
}
