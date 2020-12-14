import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'google_event.dart';
part 'google_state.dart';

class GoogleBloc extends Bloc<GoogleEvent, GoogleState> {
  GoogleBloc() : super(GoogleInitial());

  @override
  Stream<GoogleState> mapEventToState(
    GoogleEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is GoogleSubmit) {
      yield GoogleLoading();

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
        Navigator.pushNamed(event.context, '/navigationbar');
        await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        print(e);
      }
    }
  }
}
