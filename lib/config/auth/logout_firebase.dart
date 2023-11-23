import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future logout() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  try {
    await googleSignIn.signOut();
    await googleSignIn.disconnect();
  } catch (e) {
    Exception(e);
  }
  await auth.signOut();
}