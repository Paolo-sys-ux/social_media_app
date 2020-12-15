import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'delete_post_event.dart';
part 'delete_post_state.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  DeletePostBloc() : super(DeletePostInitial());

  @override
  Stream<DeletePostState> mapEventToState(
    DeletePostEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is DeletePost) {
      try {
        final postRef = FirebaseFirestore.instance.collection('post');

        await postRef.doc(event.uid).delete();

        yield DeletePostDone();
      } catch (e) {
        print(e);
        yield DeletePostError();
      }
    }
  }
}
