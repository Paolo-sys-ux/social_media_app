import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:social_media_app/bloc/facebook/facebook_bloc.dart';
import 'package:social_media_app/bloc/google/google_bloc.dart';
import 'package:social_media_app/constants/style.dart';

//Facebook Login

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // //Google Sign in
  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  //   try {
  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Create a new credential
  //     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     // Once signed in, return the UserCredential
  //     Navigator.pushNamed(context, '/home');
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //Facebook login
  // final fbLogin = FacebookLogin();
  // Future signInFB() async {
  //   try {
  //     final FacebookLoginResult result = await fbLogin.logIn(["email"]);
  //     final String token = result.accessToken.token;
  //     final response = await http.get(
  //         'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
  //     final profile = jsonDecode(response.body);

  //     print(profile);

  //     return profile;
  //   } catch (e) {
  //     print(e);
  //   }
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
      body: Column(
        children: [
          BlocBuilder<FacebookBloc, FacebookState>(
            builder: (context, state) {
              if (state is FacebookLoading) {
                return CircularProgressIndicator();
              } else if (state is FacebookError) {
                return Text('Error Signin');
              }
              return SizedBox.shrink();
            },
          ),
          BlocBuilder<GoogleBloc, GoogleState>(
            builder: (context, state) {
              if (state is GoogleLoading) {
                return CircularProgressIndicator();
              } else if (state is GoogleError) {
                return Text('Error Signin');
              }
              return Text('');
            },
          ),
        ],
      ),
      bottomSheet: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            elevation: 3,
            child: InkWell(
              onTap: () {
                BlocProvider.of<GoogleBloc>(context)
                    .add(GoogleSubmit(context: context));
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Sign in with Google',
                    style:
                        kTextButton.copyWith(color: Colors.black, fontSize: 22),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            elevation: 3,
            child: InkWell(
              onTap: () {
                BlocProvider.of<FacebookBloc>(context)
                    .add(FacebookSubmit(context: context));
                // signInFB()
                //     .whenComplete(() => Navigator.pushNamed(context, '/home'));
              },
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    'Login with Facebook',
                    style:
                        kTextButton.copyWith(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
