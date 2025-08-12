import 'package:felix_cafe/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  //text fields
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign in to Felix Cafe',
        style: TextStyle(
          color: Colors.black,
        ),
        ),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person,
            color: Colors.black,
            ),
            onPressed: (){
              widget.toggleView();
            },
            label: Text('Register',
            style: TextStyle(
              color: Colors.black,
            ),
            ))
        ],
      ) ,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:50, vertical: 20 ),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                onChanged: (value) {
                setState(()=>email = value);  
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(()=>password = value);
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  print(email);
                  print(password);
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  ),
                ), // Pink background 
                child: Text('sign in',
                style: TextStyle(
                  color: Colors.black,
                ),),
                ),
            ],
          ))
      ),
    );
  }
}