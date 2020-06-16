import 'package:airquality/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFireBase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // Sign In Anon
  Future signInAnnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      
      return _userFromFireBase(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
  // Sign In email password

  // Register email password

  // Sign Out

}