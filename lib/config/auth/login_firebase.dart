import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<(String, bool)> signInWithEmailPassword(String email, String password) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return ('Successful login',true);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return ('User not registered yet',false);
    } else if (e.code == 'wrong-password') {
      return ('Email or Password invalidated',false);
    }
    return ('Error: $e',false);
  }
}