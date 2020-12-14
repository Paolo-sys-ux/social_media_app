import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as basename;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
        String fileName = basename.basename(event.image.path);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('uploads/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(event.image);
        TaskSnapshot taskSnapshot = await uploadTask;
        taskSnapshot.ref.getDownloadURL().then(
              (value) => print("Done: $value"),
            );
        yield UploadImageDone(doneMessage: 'Upload Successful');
      } catch (e) {
        print(e);
        yield UploadImageError(errorMessage: 'Error Uploading');
      }
    }
  }
}
