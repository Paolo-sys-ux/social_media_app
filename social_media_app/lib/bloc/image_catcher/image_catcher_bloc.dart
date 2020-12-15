import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_catcher_event.dart';
part 'image_catcher_state.dart';

class ImageCatcherBloc extends Bloc<ImageCatcherEvent, ImageCatcherState> {
  ImageCatcherBloc() : super(ImageCatcherInitial());

  @override
  Stream<ImageCatcherState> mapEventToState(
    ImageCatcherEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is CatcherSubmit) {
      yield ImageCatcherLoading();
    }
  }
}
