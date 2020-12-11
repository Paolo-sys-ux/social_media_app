import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/style.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    try {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      Navigator.pushNamed(context, '/home');
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult result = await FacebookAuth.instance.login();

  //   // Create a credential from the access token
  //   final FacebookAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(result.accessToken.token);

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Social Media App',
          style: kTextButton.copyWith(color: Colors.white),
        ),
      ),
      body: Container(),
      bottomSheet: Column(
        children: [
          InkWell(
            onTap: () {
              signInWithGoogle();
            },
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Sign in with Google',
                  style:
                      kTextButton.copyWith(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              //signInWithFacebook();
            },
            child: Container(
              width: double.infinity,
              height: 50,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Sign in with Google',
                  style:
                      kTextButton.copyWith(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
