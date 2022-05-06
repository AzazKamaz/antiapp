part of 'notes_bloc.dart';

class NotesEvent {}

class AddNote extends NotesEvent {
  final String content;

  AddNote(this.content);
}

class LoadNotes extends NotesEvent {}
