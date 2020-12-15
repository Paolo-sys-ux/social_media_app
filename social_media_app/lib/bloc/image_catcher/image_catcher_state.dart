part of 'image_catcher_bloc.dart';

@immutable
abstract class ImageCatcherState {}

class ImageCatcherInitial extends ImageCatcherState {}

class ImageCatcherLoading extends ImageCatcherState {}

class ImageCatcherError extends ImageCatcherState {}
