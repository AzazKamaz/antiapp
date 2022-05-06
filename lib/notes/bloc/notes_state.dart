part of 'notes_bloc.dart';

class NotesState {
  final List<NotesModel> notes;

  NotesState(this.notes);
}

class NotesLoading extends NotesState {
  NotesLoading(List<NotesModel> notes) : super(notes);
}

class NotesLoaded extends NotesState {
  NotesLoaded(List<NotesModel> notes) : super(notes);
}
