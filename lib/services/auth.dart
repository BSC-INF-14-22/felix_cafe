import 'package:felix_cafe/models/user.dart' as app_model; // Avoid naming conflict
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user based on Firebase User object
  app_model.User? _userFromFirebaseUser(User? user) {
    return user != null ? app_model.User(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<app_model.User?> get user {
    return _auth.authStateChanges().map( _userFromFirebaseUser);
  }

  // Sign in anonymously
  Future<app_model.User?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // TODO: sign in with email & password
  // TODO: register with email & password
  Future RegisterWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // TODO: sign out
  Future SignOut()async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
