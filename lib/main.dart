import 'package:felix_cafe/models/user.dart' as app_model;
import 'package:felix_cafe/screens/wrapper.dart';
import 'package:felix_cafe/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:felix_cafe/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<app_model.User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}



