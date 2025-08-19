import 'package:felix_cafe/screens/home/brew_list.dart';
import 'package:felix_cafe/screens/home/settings_form.dart';
import 'package:felix_cafe/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:felix_cafe/services/database.dart';
import 'package:provider/provider.dart';
import 'package:felix_cafe/models/brew.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel(){
     showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal:60),
          child: SettingsForm(),
        );
      });
    }
    
    final user = Provider.of<User?>(context); // get current logged-in user

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: user?.uid).brews, // pass actual uid
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: const Text(
            'Felix Cafe',
            style: TextStyle(color: Colors.white,fontSize: 20.0),
          ),
          backgroundColor: Colors.brown[400],
          centerTitle: false,
          elevation: 0.0,
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _auth.SignOut();
              },
              icon: const Icon(Icons.person, color: Colors.black),
              label: const Text(
                'logout',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton.icon(
              onPressed: ()=> showSettingsPanel(),
              label: Text('settings',
              style: TextStyle(
                color: Colors.black,
              ),
              ),
              icon: Icon(Icons.settings,
              color: Colors.black,
              ),
              )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/coffee_bg.png"),
              fit: BoxFit.cover,
              )
          ),
          child: BrewList()
          ),
      ),
    );
  }
}
