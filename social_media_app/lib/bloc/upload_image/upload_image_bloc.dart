import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
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

          //
          var postUrl = "fcm.googleapis.com/fcm/send";
          Future<void> sendNotification(receiver, msg) async {
            var token = await getToken(receiver);
            print('token : $token');

            final data = {
              "notification": {
                "body": "Accept Ride Request",
                "title": "This is Ride Request"
              },
              "priority": "high",
              "data": {
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "id": "1",
                "status": "done"
              },
              "to":
                  "${'fSslRzOSSimaaRzaVJQJYL:APA91bG8_7zRTibxSofSmQLWc8uc_cxy4fXI6ZiLwaPhRwHtPpBVC_ECR6FSCqWXeDKrVo7FELVY7FZVWaGBKue6ZM4YpNa_FDppGxM9-sjKjIM2oarlu2XNklffURd7oDPZC6QSf8u1'}"
            };

            final headers = {
              'content-type': 'application/json',
              'Authorization':
                  'key=fSslRzOSSimaaRzaVJQJYL:APA91bG8_7zRTibxSofSmQLWc8uc_cxy4fXI6ZiLwaPhRwHtPpBVC_ECR6FSCqWXeDKrVo7FELVY7FZVWaGBKue6ZM4YpNa_FDppGxM9-sjKjIM2oarlu2XNklffURd7oDPZC6QSf8u1'
            };

            BaseOptions options = new BaseOptions(
              connectTimeout: 5000,
              receiveTimeout: 3000,
              headers: headers,
            );

            try {
              final response = await Dio(options).post(postUrl, data: data);

              if (response.statusCode == 200) {
                print('Request Sent To Driver');
              } else {
                print('notification sending failed');
                // on failure do sth
              }
            } catch (e) {
              print('exception $e');
            }
          }
        }
      } catch (e) {
        print(e);
        yield UploadImageError(errorMessage: 'Error Uploading');
      }
    }
  }

  getToken(receiver) {}
}
