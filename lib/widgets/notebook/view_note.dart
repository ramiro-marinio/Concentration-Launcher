import 'package:concentrationscreen/classes/note.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatelessWidget {
  final Note note;
  const ViewNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Text(
            note.body,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
