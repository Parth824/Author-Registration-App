import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firbase_Hlper {
  Firbase_Hlper._();

  static final Firbase_Hlper fireHleper = Firbase_Hlper._();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<Map<String,dynamic>> annauser() async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      User? user = userCredential.user;
      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "user-not-found":
          res['error'] = "User is not Exitesing...";
          break;
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> sign_up(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};

    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "email-already-in-use":
          res['error'] = "User alread Exitesing...";
          break;
        case "weak-password":
          res['error'] = "Enter Log Pasword...";
          break;
        case "operation-not-allowed":
          res['error'] = "Sever is down....";
          break;
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> sign_In(
      {required String email, required String password}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "operation-not-allowed":
          res['error'] = "Sever is down....";
          break;
        case "wrong-password":
          res['error'] = "Enter the regith Pasword....";
          break;
        case "user-not-found":
          res['error'] = "User is not Exitesing...";
          break;
      }
    }
    return res;
  }

  Future<Map<String, dynamic>> google_with_login() async {
    Map<String, dynamic> res = {};
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final userCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication!.accessToken,
          idToken: googleSignInAuthentication.idToken);

      UserCredential? userC =
          await firebaseAuth.signInWithCredential(userCredential);

      User? user = userC.user;
      res['user'] = user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "user-not-found":
          res['error'] = "User is not Exitesing...";
          break;
      }
    }
    return res;
  }

  Logout() async {
    firebaseAuth.signOut();
    _googleSignIn.signOut();
  }
}
