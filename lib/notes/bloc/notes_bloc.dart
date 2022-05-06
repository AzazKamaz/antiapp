import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../notes_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final FirebaseFirestore _firestore;
  NotesBloc(this._firestore) : super(NotesState([])) {
    on<LoadNotes>(_loadNotes);
    on<AddNote>(_addNote);
    add(LoadNotes());
  }

  FutureOr<void> _loadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading(state.notes));

    final snapshot = await _firestore.collection('notes').get();
    final notes =
        snapshot.docs.map((doc) => NotesModel.fromJson(doc.data())).toList();
    final id = await _getId();
    if (id == null) {
      emit(NotesLoaded(notes));
    } else {
      final filteredNotes = notes.where((note) => note.uuid != id).toList();
      emit(NotesLoaded(filteredNotes));
    }
  }

  FutureOr<void> _addNote(AddNote event, Emitter<NotesState> emit) async {
    emit(NotesLoading(state.notes));
    final id = await _getId();
    if (id != null) {
      final note = NotesModel(id, event.content);
      await _firestore.collection('notes').add(note.toJson());
      add(LoadNotes());
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
    throw Exception('Unknown platform');
  }
}
