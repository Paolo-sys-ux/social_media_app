part of 'upload_image_bloc.dart';

@immutable
abstract class UploadImageEvent {}

class UploadImage extends UploadImageEvent {
  File image;
  UploadImage({this.image});
}

class ViewImage extends UploadImageEvent {
  ViewImage();
}
