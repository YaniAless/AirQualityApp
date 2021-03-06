import 'package:airquality/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFireBaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid, email: user.email, creationDate: user.metadata.creationTime) : null;
  }

  //
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser);
  }

  // Sign In email password
  Future signInWithEmailAndPwd(String email, String pwd) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      print(result.user.metadata.creationTime);
      FirebaseUser user = result.user;

      return _userFromFireBaseUser(user);

    } catch(e){
      print(e.toString());
      return null;
    }
  }
  // Register email password
  Future registerWithEmailAndPwd(String email, String pwd) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pwd);

      FirebaseUser user = result.user;

      return _userFromFireBaseUser(user);

    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
    }
  }
}