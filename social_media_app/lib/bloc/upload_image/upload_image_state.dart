part of 'upload_image_bloc.dart';

@immutable
abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageDone extends UploadImageState {
  final String doneMessage;

  UploadImageDone({this.doneMessage});
}

class UploadImageError extends UploadImageState {
  final String errorMessage;

  UploadImageError({this.errorMessage});
}
