import 'package:felix_cafe/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
final AuthService _auth =AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Felix Cafe',
        style: TextStyle(
          color: Colors.black
        ),
        ),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
        elevation: 0.0,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.SignOut();
            },
            icon: Icon(Icons.person,
            color: Colors.black,
            ),
            label: Text('logout',
            style: TextStyle(
              color: Colors.black
            ),
            ),
          
            )
        ],
      ),

    );
  }
}