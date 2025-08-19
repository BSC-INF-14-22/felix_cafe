import 'package:felix_cafe/services/auth.dart';
import 'package:felix_cafe/shared/constant.dart';
import 'package:felix_cafe/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
   final _formkey = GlobalKey<FormState>();
   bool loading = false;
  //text fields
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/sign in.webp"),
              fit: BoxFit.cover,
              )
          ),        
        padding: EdgeInsets.symmetric(horizontal:50, vertical: 20 ),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email',
                errorStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[500]
                )
                ),
                validator: (value)=>value==null || value.isEmpty?'Enter an email':null,                
                onChanged: (value) {
                setState(()=>email = value);  
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password',
                errorStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.red[500]
                )
                ),
                validator: (value)=>value==null || value.length < 6?'Enter a password with more than 6 characters':null,                
                obscureText: true,
                onChanged: (value) {
                  setState(()=>password = value);
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async{
                  if(_formkey.currentState!.validate()){
                    setState(()=>loading = true);
                    dynamic result = await _auth.SignInWithEmailAndPassword(email,password);
                    if(result==null){
                    setState(() {
                      error = 'Credentials Invalid';
                      loading = false;
                      }
                      );
                  }
                  }
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
                                SizedBox(height: 10.0,),
                Text(error,
                style: TextStyle(
                  color: Colors.red[500],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                )
            ],
          ))
      ),
    );
  }
}