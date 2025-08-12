import 'package:felix_cafe/screens/aunthetication/authenticate.dart';
import 'package:felix_cafe/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:felix_cafe/models/user.dart' as app_model;

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<app_model.User?>(context);
    print(user?.uid);
    //return either home or authentication
   if (user == null){
    return Authenticate();
   }
   else{
    return Home();
   }
  }
}