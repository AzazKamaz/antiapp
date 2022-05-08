import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'bloc/notes_bloc.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late NotesBloc _bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (context) {
        _bloc = NotesBloc(FirebaseFirestore.instance);
        return _bloc;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('antinotes'.tr())),
        floatingActionButton: FloatingActionButton(
            onPressed: _addNoteModal, child: const Icon(Icons.add)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: BlocConsumer<NotesBloc, NotesState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is NotesLoaded) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        _bloc.add(LoadNotes());
                      },
                      child: ListView.builder(
                        itemCount: state.notes.length,
                        itemBuilder: (context, index) => Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(state.notes[index].data,
                                style: Theme.of(context).textTheme.subtitle1),
                          ),
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ),
      ),
    );
  }

  void _addNoteModal() async {
    final _controller = TextEditingController();
    final content = await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('new_note'.tr(),
                            style: Theme.of(context).textTheme.headline6),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: 'note'.tr(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                            ),
                          ),
                          maxLines: 5,
                        ),
                        TextButton(
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                Navigator.of(context).pop(_controller.text);
                              }
                            },
                            child: Text('add'.tr())),
                      ],
                    ),
                  )),
            ));
    if (content != null) {
      _bloc.add(AddNote(content));
    }
  }
}
