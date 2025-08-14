import 'package:felix_cafe/shared/constant.dart';
import 'package:felix_cafe/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:felix_cafe/services/auth.dart';

class Register extends StatefulWidget {
  
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  //text fields
  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
                actions: [
          TextButton.icon(
            icon: Icon(Icons.person,
            color: Colors.black,
            ),
            onPressed: (){
              widget.toggleView();
            },
            label: Text('Sign In',
            style: TextStyle(
              color: Colors.black,
            ),
            ))
        ],
        title: Text('Sign up to Felix Cafe',
        style: TextStyle(
          color: Colors.black,
        ),
        ),
      ) ,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:50, vertical: 20 ),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (value)=>value==null || value.isEmpty?'Enter an email':null,
                onChanged: (value) {
                setState(()=>email = value);  
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'password'),
                validator: (value)=>value==null || value.length < 6?'Enter password with more than 6 characters':null,
                 obscureText: true,
                onChanged: (value) {
                  setState(()=>password = value);
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  if(_formkey.currentState!.validate()){
                    setState(()=>loading=true);
                  dynamic result = await _auth.RegisterWithEmailAndPassword(email,password);
                  if(result==null){
                    setState((){ 
                      error = 'please supply a valid email or password';
                      loading=false;
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
                child: Text('Register',
                style: TextStyle(
                  color: Colors.black,
                ),),
                ),
                SizedBox(height: 10.0,),
                Text(error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
                )
            ],
          ))
      ),
    );
  }
}