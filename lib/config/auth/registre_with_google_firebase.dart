import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<(String, bool)> signInWithGoogleAccount() async {
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  if (gUser == null) {
    return ('User canceled login', false);
  }
  try {
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
    
    return ('Successful login Google account', true);
  } catch (e) {
    return ('Error: $e', false);
  }
}
