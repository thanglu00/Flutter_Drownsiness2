import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart'; // ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';

class AuthClass{
  FirebaseAuth auth = FirebaseAuth.instance;
  void signOut(){
    auth.currentUser!.delete();
    auth.signOut();
    GoogleSignIn().signOut();
    FacebookLogin().logOut();
  }
  Future signInWithGoogle() async{
    final GoogleSignInAccount googleUser;
    googleUser = (await GoogleSignIn().signIn())!;
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);

    }
    Future signInWithFacebook() async{
      final FacebookLoginResult result = await FacebookLogin().logIn(['email']);
      if(result.status == FacebookLoginStatus.loggedIn) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
        return await FirebaseAuth.instance.signInWithCredential(
            credential);
      }
    }

  // Future<void> submitPhoneNumber(String phonenumber) async{
  //   void verificationCompleted(AuthCredential phoneAuthCredential){
  //     print('verification Complete');
  //
  //     this._phoneAuthCredential = phoneAuthCredential;
  //
  //   }
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phonenumber,
  //       timeout: Duration(milliseconds: 10000),
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)

}