import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<(String, bool)> registerWithEmailPassword(String email, String password) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return ('Successful registration',true);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      return('An account already exists with that email.',false);
    }
    return ('Error : $e',false);
  }
}