part of 'image_catcher_bloc.dart';

@immutable
abstract class ImageCatcherEvent {}

class CatcherSubmit extends ImageCatcherEvent {
  CatcherSubmit();
}
