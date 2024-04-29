import 'package:auto_size_text/auto_size_text.dart';
import 'package:concentrationscreen/classes/note.dart';
import 'package:concentrationscreen/pages/notebook/edit.dart';
import 'package:concentrationscreen/providers/appstate.dart';
import 'package:concentrationscreen/widgets/are_you_sure.dart';
import 'package:concentrationscreen/widgets/notebook/view_note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoteDisplay extends StatelessWidget {
  final Note note;
  const NoteDisplay({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final AppState appState = context.read<AppState>();
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  note.title,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 9,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'Created ${DateFormat('MMMM d y HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(note.createdAt))}',
                ),
                Text(
                  'Last updated on ${DateFormat('MMMM d y HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(note.updatedAt))}',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewNote(note: note),
                          ),
                        );
                      },
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Edit(
                              editNote: note,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AreYouSure(
                            yes: () => appState.deleteEntry(note),
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
