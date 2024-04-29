import 'package:concentrationscreen/pages/notebook/edit.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:concentrationscreen/widgets/apps/searchbar.dart';
import 'package:concentrationscreen/widgets/notebook/note_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivateNotebook extends StatefulWidget {
  const PrivateNotebook({super.key});

  @override
  State<PrivateNotebook> createState() => _PrivateNotebookState();
}

class _PrivateNotebookState extends State<PrivateNotebook> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Private Notebook'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Edit(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: appState.notes != null
          ? SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppSearchBar(
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                    title: 'Search notes...',
                  ),
                ),
                ...appState.notes!.map((e) => Visibility(
                      visible:
                          e.title.toLowerCase().contains(search.toLowerCase()),
                      child: NoteDisplay(note: e),
                    )),
              ]),
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
