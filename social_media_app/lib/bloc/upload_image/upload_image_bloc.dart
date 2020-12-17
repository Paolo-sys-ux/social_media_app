import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as basename;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UploadImageBloc() : super(UploadImageInitial());

  @override
  Stream<UploadImageState> mapEventToState(
    UploadImageEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is UploadImage) {
      yield UploadImageLoading();

      try {
        String _fileName = basename.basename(event.image.path);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('uploads/$_fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(event.image);

        TaskSnapshot taskSnapshot = await uploadTask;
        taskSnapshot.ref.getDownloadURL().then(
              (value) => print("Done: $value"),
            );
        yield UploadImageDone(doneMessage: 'Upload Successful');

        //saving in cloud firestore
        if (event.image != null) {
          Reference ref = FirebaseStorage.instance.ref();
          TaskSnapshot addImg =
              await ref.child("image/img").putFile(event.image);
          if (addImg != null) {
            final String downloadUrl = await addImg.ref.getDownloadURL();
            await FirebaseFirestore.instance
                .collection("post")
                .doc()
                .set({"url": downloadUrl, "name": _fileName});
          }

          //Fcm
          try {
            var postUrl = "https://fcm.googleapis.com/fcm/send";

            var token =
                'eO-qc2ERRTSmP0VefMyIGv:APA91bF7pmgiNevYdTrUsc0lyDCE7a81JGITIJcMYL2Fh30dUO6ABPuQzv56JnM7RtybemX7iCJ-yAbZvq_MyALCgcAd6rEF_JDA-lcddeH-cW3NcTCR4Iv_zfhDFtcMve9KUj2TLNEc';
            print(token);
            final data = {
              "notification": {
                "body": "Post Uploaded",
                "title": "New Post Uploaded"
              },
              "priority": "high",
              "data": {
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "id": "1",
                "status": "done"
              },
              "to": "$token"
            };

            final headers = {
              'Accept': "application/json",
              'Authorization':
                  'key = AAAA6o07JNA:APA91bE_YzzD89H6tqRzgyhBUVeZ96vwXA_TRMeAvYFF6l85eGbIYlkPhx0kNKmsT-yHzU5MWGW2QRrx4ZDA-SZv1O4XJRH9tABSlrd2TCxZmUBnrKI2CLKJVXOIEm0MmJDiUK8yUaF-',
            };

            BaseOptions options = new BaseOptions(
              connectTimeout: 5000,
              receiveTimeout: 3000,
              headers: headers,
            );

            try {
              final response =
                  await Dio(options).post(postUrl, data: json.encode(data));

              if (response.statusCode == 200) {
                print('Notif sended');
              } else {
                print('notification sending failed');
                // on failure do sth
              }
            } catch (e) {
              print('exception $e');
            }
          } catch (e) {}
        }
      } catch (e) {
        print(e);
        yield UploadImageError(errorMessage: 'Error Uploading');
      }
    }
  }

  getToken(receiver) {}
}
